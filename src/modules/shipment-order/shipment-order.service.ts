/* eslint-disable @typescript-eslint/no-explicit-any */
import status from "http-status";
import { prisma } from "../../database/prisma";
import { AppError } from "../../shared/errors/app-error";
import { DhCreateShipmentOrder } from "../../interface/shipment.interface";

const createShipmentOder = async (distributionHouseId: string, payload: DhCreateShipmentOrder) => {
    if (!distributionHouseId) {
        throw new AppError(status.BAD_REQUEST, "Distribution House ID is required");
    }

    const allSkuCodes = [
        ...new Set(
            payload.orders.flatMap((group) => group.items.map((item) => item.shipmentSkuId))
        ),
    ];

    const skus = await prisma.shipmentSku.findMany({
        where: {
            code: { in: allSkuCodes },
        },
        select: {
            id: true,
            code: true,
        },
    });

    const skuMap = new Map(skus.map((sku) => [sku.code, sku.id]));
    const skuIds = Array.from(skuMap.values());

    const prices = await prisma.distributorPrice.findMany({
        where: {
            ShipmentSku: {
                some: {
                    id: { in: skuIds },
                },
            },
        },
        select: {
            price: true,
            ShipmentSku: {
                select: {
                    id: true,
                },
            },
        },
    });

    const priceMap = new Map<string, number>();
    prices.forEach((p) => {
        p.ShipmentSku.forEach((sku) => {
            priceMap.set(sku.id, p.price);
        });
    });

    const operations = payload.orders.flatMap((orderGroup) => {
        const formattedTargetDate = new Date(orderGroup.targetDate);

        return orderGroup.items.map((item) => {
            const actualSkuId = skuMap.get(item.shipmentSkuId) || item.shipmentSkuId;

            if (!actualSkuId) {
                throw new AppError(status.BAD_REQUEST, `Invalid SKU Code: ${item.shipmentSkuId}`);
            }

            const formattedQuantity = parseFloat(Number(item.quantity).toFixed(2));

            return prisma.shipmentOrder.upsert({
                where: {
                    shipmentSkuId_targetDate_distributionHouseId: {
                        shipmentSkuId: actualSkuId,
                        targetDate: formattedTargetDate,
                        distributionHouseId: distributionHouseId,
                    },
                },
                update: {
                    quantity: formattedQuantity,
                },
                create: {
                    shipmentSkuId: actualSkuId,
                    quantity: formattedQuantity,
                    targetDate: formattedTargetDate,
                    distributionHouseId: distributionHouseId,
                    isFinalized: true,
                    unlockRequested: false,
                },
                include: {
                    shipmentSku: {
                        select: {
                            name: true,
                            packSize: true,
                        },
                    },
                    distributionHouse: {
                        select: {
                            name: true,
                        },
                    },
                },
            });
        });
    });

    const results = await prisma.$transaction(operations);

    const groupedResult = results.reduce((acc, order) => {
        const dateKey = new Date(order.targetDate).toISOString().split('T')[0];

        if (!acc[dateKey]) {
            acc[dateKey] = [];
        }

        const price = priceMap.get(order.shipmentSkuId);

        const orderWithPrice = {
            ...order,
            distributorPrices: price !== undefined ? [{ price }] : [],
        };

        acc[dateKey].push(orderWithPrice);
        return acc;
    }, {} as Record<string, Array<typeof results[number] & { distributorPrices: { price: number }[] }>>);

    return groupedResult;
};

const getAllShipmentOrders = async () => {
    return await prisma.shipmentOrder.findMany({
        orderBy: {
            targetDate: 'asc',
        },
        include: {
            shipmentSku: {
                select: {
                    name: true,
                    packSize: true,
                    distributorPrice: {
                        select: { price: true },
                    }
                },
            },
            distributionHouse: {
                select: { name: true },
            },
        },
    });
};

// 🔹 2. Get Shipment Orders By Date
const getShipmentOrdersByDate = async (distributionHouseId: string, date: string) => {
    const queryDate = new Date(date);
    queryDate.setHours(0, 0, 0, 0);
    const nextDay = new Date(queryDate.getTime() + 24 * 60 * 60 * 1000);

    const orders = await prisma.shipmentOrder.findMany({
        where: {
            distributionHouseId: distributionHouseId,
            targetDate: {
                gte: queryDate,
                lt: nextDay,
            },
        },
        orderBy: {
            targetDate: 'asc',
        },
        include: {
            shipmentSku: {
                select: {
                    name: true,
                    packSize: true,
                    distributorPrice: {
                        select: {
                            price: true,
                        },
                    },
                },
            },
            distributionHouse: {
                select: {
                    name: true,
                },
            },
        },
    });

    return orders.map((order) => {
        const { distributorPrice, ...skuData } = order.shipmentSku;
        return {
            ...order,
            shipmentSku: skuData,
            distributorPrices: distributorPrice || [],
        };
    });
};

export const shipmentOrderService = {
    createShipmentOder,
    getShipmentOrdersByDate,
    getAllShipmentOrders
};
