import status from "http-status";
import { prisma } from "../../database/prisma";
import { DhCreateShipmentOrder } from "../../interface/shipmentOrder.interface";
import { AppError } from "../../shared/errors/app-error";

const createShipmentOder = async (distributionHouseId: string, payload: DhCreateShipmentOrder) => {
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
    const operations = payload.orders.flatMap((orderGroup) => {
        const formattedTargetDate = new Date(orderGroup.targetDate);

        return orderGroup.items.map((item) => {
            const actualSkuId = skuMap.get(item.shipmentSkuId) || item.shipmentSkuId;

            if (!actualSkuId) {
                throw new AppError(status.BAD_REQUEST, `Invalid SKU Code: ${item.shipmentSkuId}`);
            }

            return prisma.shipmentOrder.upsert({
                where: {
                    shipmentSkuId_targetDate_distributionHouseId: {
                        shipmentSkuId: actualSkuId,
                        targetDate: formattedTargetDate,
                        distributionHouseId: distributionHouseId,
                    },
                },
                update: {
                    quantity: Number(item.quantity),
                },
                create: {
                    shipmentSkuId: actualSkuId,
                    quantity: Number(item.quantity),
                    targetDate: formattedTargetDate,
                    distributionHouseId: distributionHouseId,
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
                        }
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
        acc[dateKey].push(order);
        return acc;
    }, {} as Record<string, typeof results>);

    return groupedResult;
};

const getShipmentOrdersByDate = async (distributionHouseId: string) => {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const result = await prisma.shipmentOrder.findMany({
        where: {
            distributionHouseId: distributionHouseId,
            targetDate: {
                gte: today,
            },
        },
        orderBy: {
            targetDate: 'asc',
        },
    });

    return result;
};

const getShipmentSku = async () => {
    const result = await prisma.shipmentSku.findMany();
    return result;
}


export const shipmentOrderService = {
    createShipmentOder,
    getShipmentOrdersByDate,
    getShipmentSku
};
