/* eslint-disable @typescript-eslint/no-explicit-any */
import { Request, Response } from "express";
import { status } from "http-status";
import { sendResponse } from "../../shared/utils/send-response";
import { catchAsync } from "../../shared/utils/catch-async";
import { territoryService } from "./territory.service";

const createTerritory = catchAsync(async (req: Request, res: Response) => {
    const { distributionId } = req.params;
    const payload = req.body;
    const userId = (req.user as any)?.id || (req.user as any)?.user?.id;

    const result = await territoryService.createTerritory(payload, userId, distributionId as string);

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: "Territory houses created successfully",
        data: result,
    });
});

const getAllTerritory = catchAsync(async (req: Request, res: Response) => {
    const result = await territoryService.getAllTerritory()

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: "Territory retrive successfully",
        data: result,
    });
});




export const territoryController = {
    createTerritory,
    getAllTerritory
}