/* eslint-disable @typescript-eslint/no-explicit-any */
import { Request, Response } from "express";
import { status } from "http-status";
import { sendResponse } from "../../shared/utils/send-response";
import { catchAsync } from "../../shared/utils/catch-async";
import { distributionService } from "./distribution.service";

const createDistribution = catchAsync(async (req: Request, res: Response) => {
    const { areaId } = req.params; // Extract from URL
    const payload = req.body;
    const userId = (req.user as any)?.id || (req.user as any)?.user?.id;

    const result = await distributionService.createDistribution(payload, userId, areaId as string);

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: "Distribution houses created successfully",
        data: result,
    });
});

const getAllDistribution = catchAsync(async (req: Request, res: Response) => {
    const result = await distributionService.getAllDistribution()

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: "Distribution houses retrive successfully",
        data: result,
    });
});

export const distributionController = {
    createDistribution,
    getAllDistribution
}