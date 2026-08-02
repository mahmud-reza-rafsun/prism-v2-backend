import { prisma } from "../../database/prisma";
import { DhCreateShipmentOrder } from "../../interface/shipmentOrder.interface";

const createShipmentOder = async (distributionHouseId: string, payload: DhCreateShipmentOrder) => {
    const operations = payload.orders.flatMap((orderGroup) => {
        const formattedTargetDate = new Date(orderGroup.targetDate);

        return orderGroup.items.map((item) =>
            prisma.shipmentOrder.upsert({
                where: {
                    shipmentSkuId_targetDate_distributionHouseId: {
                        shipmentSkuId: item.shipmentSkuId,
                        targetDate: formattedTargetDate,
                        distributionHouseId: distributionHouseId,
                    },
                },
                update: {
                    quantity: Math.round(item.quantity),
                },
                create: {
                    shipmentSkuId: item.shipmentSkuId,
                    quantity: Math.round(item.quantity),
                    targetDate: formattedTargetDate,
                    distributionHouseId: distributionHouseId,
                },
            })
        );
    });

    const result = await prisma.$transaction(operations);
    return result;
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
