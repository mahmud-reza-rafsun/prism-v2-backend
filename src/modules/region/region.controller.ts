/* eslint-disable @typescript-eslint/no-explicit-any */
import { Request, Response } from "express";
import { status } from "http-status";
import { regionService } from "./region.service";
import { sendResponse } from "../../shared/utils/send-response";
import { catchAsync } from "../../shared/utils/catch-async";

const createRegion = catchAsync(async (req: Request, res: Response) => {
    const payload = req.body;
    console.log("Incoming Body:", req.body);

    // Extracting user ID safely from Better Auth session
    const userId = (req.user as any)?.id || (req.user as any)?.user?.id;

    const result = await regionService.createRegions(payload, userId);

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: "Regions created successfully!!",
        data: result,
    });
});

export const regionController = {
    createRegion
};