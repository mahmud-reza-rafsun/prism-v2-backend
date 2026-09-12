import { z } from "zod";

export const createOrderSchema = z.object({
    body: z.object({
        orders: z.array(
            z.object({
                targetDate: z.string().date(),
                items: z.array(
                    z.object({
                        shipmentSkuId: z.string().min(1, "Shipment SKU ID is required"),

                        quantity: z.number().positive("Quantity must be greater than 0"),
                    })
                ).min(1, "At least one item is required"),
            })
        ).min(1, "At least one order is required"),
    }),
});
