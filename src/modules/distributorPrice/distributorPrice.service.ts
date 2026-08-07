import status from "http-status";
import { prisma } from "../../database/prisma";
import { TDistributorPricePayload } from "../../interface/distributorPrice.interface";
import { AppError } from "../../shared/errors/app-error";

const createDistributorPrices = async (payload: TDistributorPricePayload) => {
    const codes = [
        ...new Set(
            payload?.items
                ?.map((item) => item.code)
                .filter((code): code is string => Boolean(code) && code.trim() !== "")
        ),
    ];
    if (codes.length === 0) {
        throw new AppError(status.NOT_FOUND, "No valid SKU codes provided in payload items.");
    }

    const skus = await prisma.shipmentSku.findMany({
        where: { code: { in: codes } },
        select: { id: true, code: true },
    });

    const skuMap = new Map(skus.map((s) => [s.code, s.id]));

    const operations = payload.items.map((item) => {
        const skuId = skuMap.get(item.code);
        return prisma.distributorPrice.create({
            data: {
                price: Number(item.price),
                ShipmentSku: { connect: [{ id: skuId }] },
            },
            include: { ShipmentSku: { select: { code: true } } },
        });
    });

    const result = await prisma.$transaction(operations, {
        timeout: 60000,
    });

    return result.map((res) => ({
        code: res.ShipmentSku[0]?.code || '',
        price: res.price,
    }));
};

const updateDistributorPrices = async (payload: TDistributorPricePayload) => {
    const codes = [
        ...new Set(
            payload?.items
                ?.map((item) => item.code)
                .filter((code): code is string => Boolean(code) && code.trim() !== "")
        ),
    ];

    if (codes.length === 0) {
        throw new AppError(status.NOT_FOUND, "No valid SKU codes provided in payload items.");
    }

    const skusWithPrice = await prisma.shipmentSku.findMany({
        where: { code: { in: codes } },
        select: {
            id: true,
            code: true,
            distributorPriceId: true,
        },
    });

    const skuMap = new Map(skusWithPrice.map((s) => [s.code, s]));

    const operations = payload.items.map((item) => {
        const skuData = skuMap.get(item.code);

        if (!skuData || !skuData.distributorPriceId) {
            throw new AppError(status.NOT_FOUND, `SKU '${item.code}' Please Create the distributor price first before updating.`);
        }

        return prisma.distributorPrice.update({
            where: {
                id: skuData.distributorPriceId,
            },
            data: {
                price: Number(item.price),
            },
            include: {
                ShipmentSku: {
                    select: { code: true },
                },
            },
        });
    });

    const result = await prisma.$transaction(operations, {
        timeout: 15000,
    });

    return result.map((res) => ({
        code: res.ShipmentSku[0]?.code || '',
        price: res.price,
    }));
};

export const distributorPriceService = {
    createDistributorPrices,
    updateDistributorPrices,
};
