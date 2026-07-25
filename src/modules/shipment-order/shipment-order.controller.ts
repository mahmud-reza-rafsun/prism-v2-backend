import { Request, Response } from "express";
import { catchAsync } from "../../shared/utils/catch-async";
import { shipmentOrderService } from "./shipment-order.service";
import { sendResponse } from "../../shared/utils/send-response";
import status from "http-status";

const createShipmentOder = catchAsync(async (req: Request, res: Response) => {
    const distributionHouseId = req.user?.distributionHouseId as string;
    const result = await shipmentOrderService.createShipmentOder(distributionHouseId, req.body);

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: 'Shipment order created successfully',
        data: result,
    });
});

const getShipmentOrdersByDate = catchAsync(async (req: Request, res: Response) => {
    const distributionHouseId = req.user?.distributionHouseId as string;
    const result = await shipmentOrderService.getShipmentOrdersByDate(distributionHouseId);

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: 'Shipment orders fetched successfully',
        data: result,
    });
});

export const shipmentOrderController = {
    createShipmentOder,
    getShipmentOrdersByDate
}
