import { Request, Response } from "express";
import { catchAsync } from "../../shared/utils/catch-async";
import { shipmentOrderService } from "./shipment-order.service";
import { sendResponse } from "../../shared/utils/send-response";
import status from "http-status";

const createShipmentOder = catchAsync(async (req: Request, res: Response) => {
    const distributionHouseId = req.params?.distributionHouseId as string;
    const payload = req.body;
    const result = await shipmentOrderService.createShipmentOder(distributionHouseId, payload);

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: 'Shipment order created successfully',
        data: result,
    });
});

const getAllShipmentOrders = catchAsync(async (req: Request, res: Response) => {
    const result = await shipmentOrderService.getAllShipmentOrders();

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: "All shipment orders retrieved successfully",
        data: result,
    });
});

// Controller 2: Get Shipment Orders By Date
const getShipmentOrdersByDate = catchAsync(async (req: Request, res: Response) => {
    const { distributionHouseId, date } = req.params;

    const result = await shipmentOrderService.getShipmentOrdersByDate(
        distributionHouseId as string,
        date as string
    );

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: "Shipment orders retrieved successfully",
        data: result,
    });
});

export const shipmentOrderController = {
    createShipmentOder,
    getShipmentOrdersByDate,
    getAllShipmentOrders,
}
