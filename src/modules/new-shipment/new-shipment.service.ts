import status from "http-status";
import { prisma } from "../../database/prisma";
import { AppError } from "../../shared/errors/app-error";
import { INewShipmentPayload } from "../../interface/shipment.interface";

const createNewShipment = async (
    distributionHouseId: string,
    payload: INewShipmentPayload
) => {
    if (!distributionHouseId) {
        throw new AppError(status.BAD_REQUEST, "Distribution House ID is required");
    }

    if (!payload.items || payload.items.length === 0) {
        throw new AppError(status.BAD_REQUEST, "Shipment items are required");
    }
    const allSkuCodes = [
        ...new Set(payload.items.map((item) => item.sttSkuId.trim())),
    ];
    const skus = await prisma.sttSku.findMany({
        where: {
            OR: [
                { code: { in: allSkuCodes, mode: "insensitive" } },
                { id: { in: allSkuCodes } },
            ],
        },
        select: {
            id: true,
            code: true,
        },
    });

    const skuMap = new Map<string, string>();
    skus.forEach((sku) => {
        if (sku.code) {
            skuMap.set(sku.code.toLowerCase(), sku.id);
        }
        skuMap.set(sku.id.toLowerCase(), sku.id);
    });
    const operations = payload.items.map((item) => {
        const cleanSkuInput = item.sttSkuId.trim().toLowerCase();
        const actualSkuId = skuMap.get(cleanSkuInput);

        if (!actualSkuId) {
            throw new AppError(
                status.BAD_REQUEST,
                `Invalid SKU Code or ID: '${item.sttSkuId}' does not exist in SttSku table.`
            );
        }
        const inputValue = parseFloat(Number(item.shipmentQuantity || 0).toFixed(2));
        return prisma.newShipment.create({
            data: {
                onHandStock: inputValue,
                distributionHouseId: distributionHouseId,
                sttSku: {
                    connect: [{ id: actualSkuId }],
                },
            },
            include: {
                sttSku: {
                    select: {
                        id: true,
                        name: true,
                        code: true,
                    },
                },
                distributionHouse: {
                    select: {
                        id: true,
                        name: true,
                    },
                },
            },
        });
    });
    const results = await prisma.$transaction(operations);
    return results;
};

const getShipmentsByDistributionHouse = async (distributionHouseId: string) => {
    if (!distributionHouseId) {
        throw new AppError(status.BAD_REQUEST, "Distribution House ID is required");
    }

    return await prisma.newShipment.findMany({
        where: {
            distributionHouseId: distributionHouseId,
        },
        include: {
            sttSku: {
                select: {
                    id: true,
                    name: true,
                    code: true,
                },
            },
            distributionHouse: {
                select: {
                    id: true,
                    name: true,
                },
            },
        },
    });
};

export const newShipmentService = {
    createNewShipment,
    getShipmentsByDistributionHouse,
};
