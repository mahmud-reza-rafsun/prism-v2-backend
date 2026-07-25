import { Request, Response } from "express";
import { catchAsync } from "../../shared/utils/catch-async";
import { shipmentOrderService } from "./shipment-order.service";
import { sendResponse } from "../../shared/utils/send-response";
import status from "http-status";

const createShipmentOder = catchAsync(async (req: Request, res: Response) => {
    const { dhId } = req.params;
    const result = await shipmentOrderService.createShipmentOder(dhId as string, req.body);

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: 'Shipment order created successfully',
        data: result,
    });
});

export const shipmentOrderController = {
    createShipmentOder
}