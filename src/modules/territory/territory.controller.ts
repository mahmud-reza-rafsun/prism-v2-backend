/* eslint-disable @typescript-eslint/no-explicit-any */
import { Request, Response } from "express";
import { status } from "http-status";
import { sendResponse } from "../../shared/utils/send-response";
import { catchAsync } from "../../shared/utils/catch-async";
import { territoryService } from "./territory.service";

const createTerritory = catchAsync(async (req: Request, res: Response) => {
    const payload = req.body;

    const userId = (req.user as any)?.id || (req.user as any)?.user?.id;

    const result = await territoryService.createTerritory(payload, userId);

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: "Regions created successfully!!",
        data: result,
    });
});

export const territoryController = {
    createTerritory
};