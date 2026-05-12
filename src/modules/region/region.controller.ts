import { Request, Response } from "express";
import { catchAsync } from "../../shared/utils/catch-async";
import { sendResponse } from "../../shared/utils/send-response";
import { regionService } from "./region.service";
import status from "http-status";

const createRegion = catchAsync(
    async (req: Request, res: Response) => {
        const payload = req.body
        const { id } = req.user
        const region = await regionService.createRegions(payload, id as string);
        sendResponse(res, {
            status: status.OK,
            success: true,
            message: "Create region successful!!",
            data: region
        })
    }
);

export const regionController = {
    createRegion
}