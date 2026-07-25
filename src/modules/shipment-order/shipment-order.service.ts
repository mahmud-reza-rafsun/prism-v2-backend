import { prisma } from "../../database/prisma";
import { DhCreateShipmentOrder } from "../../interface/shipmentOrder.interface";



const createShipmentOder = async (dhId: string, payload: DhCreateShipmentOrder) => {
    const operations = payload.orders.flatMap((orderGroup) => {
        const formattedTargetDate = new Date(orderGroup.targetDate);

        return orderGroup.items.map((item) =>
            prisma.shipmentOrder.upsert({
                where: {
                    shipmentSkuId_targetDate_distributionHouseId: {
                        shipmentSkuId: item.shipmentSkuId,
                        targetDate: formattedTargetDate,
                        distributionHouseId: dhId,
                    },
                },
                update: {
                    quantity: Math.round(item.quantity),
                },
                create: {
                    shipmentSkuId: item.shipmentSkuId,
                    quantity: Math.round(item.quantity),
                    targetDate: formattedTargetDate,
                    distributionHouseId: dhId,
                },
            })
        );
    });

    const result = await prisma.$transaction(operations);
    return result;
};

export const shipmentOrderService = {
    createShipmentOder,
};