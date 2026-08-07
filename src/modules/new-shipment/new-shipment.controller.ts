import { Request, Response } from "express";
import status from "http-status";
import { newShipmentService } from "./new-shipment.service";
import { catchAsync } from "../../shared/utils/catch-async";
import { sendResponse } from "../../shared/utils/send-response";

const createNewShipment = catchAsync(async (req: Request, res: Response) => {
    const { distributionHouseId } = req.params;
    const payload = req.body;
    const result = await newShipmentService.createNewShipment(
        distributionHouseId as string,
        payload
    );

    sendResponse(res, {
        status: status.CREATED,
        success: true,
        message: "New shipment created successfully",
        data: result,
    });
});

const getShipmentsByDistributionHouse = catchAsync(async (req: Request, res: Response) => {
    const { distributionHouseId } = req.params;
    const result = await newShipmentService.getShipmentsByDistributionHouse(
        distributionHouseId as string
    );

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: "Shipments retrieved successfully for distribution house",
        data: result,
    });
});

export const newShipmentController = {
    createNewShipment,
    getShipmentsByDistributionHouse,
};
