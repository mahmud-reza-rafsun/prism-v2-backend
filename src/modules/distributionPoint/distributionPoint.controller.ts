import { Request, Response } from "express";
import { catchAsync } from "../../shared/utils/catch-async";
import { sendResponse } from "../../shared/utils/send-response";
import { distributionPointService } from "./distributionPoint.service";
import status from "http-status";

const createDistributionPoint = catchAsync(async (req: Request, res: Response) => {
    const payload = req.body;
    const userId = req.user.id;

    const result = await distributionPointService.createDistributionPoint(
        payload,
        userId
    );

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: "Distribution point created successfully",
        data: result,
    });
});

export const distributionPoints = {
    createDistributionPoint
}
