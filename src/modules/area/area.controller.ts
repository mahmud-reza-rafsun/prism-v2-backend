// modules/area/area.controller.ts
/* eslint-disable @typescript-eslint/no-explicit-any */
import { Request, Response } from "express";
import { status } from "http-status";
import { sendResponse } from "../../shared/utils/send-response";
import { catchAsync } from "../../shared/utils/catch-async";
import { areaService } from "./area.service";

const createArea = catchAsync(async (req: Request, res: Response) => {
    const payload = req.body;
    const { regionId } = req.params;
    const userId = (req.user as any)?.id;

    const result = await areaService.createArea(payload, userId, regionId as string);

    sendResponse(res, {
        status: status.OK,
        success: true,
        message: "Areas created successfully!!",
        data: result,
    });
});

export const areaController = {
    createArea,
};