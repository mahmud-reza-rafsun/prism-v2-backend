import { Request, Response } from 'express';
import status from 'http-status';
import { distributorPriceService } from './distributorPrice.service';
import { catchAsync } from '../../shared/utils/catch-async';
import { sendResponse } from '../../shared/utils/send-response';

// POST Controller
const createDistributorPrices = catchAsync(async (req: Request, res: Response) => {
    const payload = req.body;
    const result = await distributorPriceService.createDistributorPrices(payload);
    sendResponse(res, {
        status: status.CREATED,
        success: true,
        message: 'Distributor prices created successfully',
        data: { items: result },
    });
});

// PATCH Controller
const updateDistributorPrices = catchAsync(async (req: Request, res: Response) => {
    const result = await distributorPriceService.updateDistributorPrices(req.body);
    sendResponse(res, {
        status: status.OK,
        success: true,
        message: 'Distributor prices updated successfully',
        data: { items: result },
    });
});

export const distributorPriceController = {
    createDistributorPrices,
    updateDistributorPrices,
};
