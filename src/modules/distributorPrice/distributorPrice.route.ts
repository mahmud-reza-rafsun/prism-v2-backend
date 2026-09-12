import { Router } from 'express';
import { Role } from '@prisma/client';
import { checkAuth } from '../../shared/middlewares/checkAuth';
import { distributorPriceController } from './distributorPrice.controller';

const router = Router();

router.post(
    '/create-price',
    checkAuth(Role.HEAD_OF_TRADE, Role.FINANCE_CONTROLLER, Role.SUPER_ADMIN),
    distributorPriceController.createDistributorPrices
);

router.get(
    '/get-all-price',
    checkAuth(Role.HEAD_OF_TRADE, Role.FINANCE_CONTROLLER, Role.SUPER_ADMIN),
    distributorPriceController.getDistributorPrices
);

router.patch(
    '/update-price',
    checkAuth(Role.HEAD_OF_TRADE, Role.FINANCE_CONTROLLER, Role.SUPER_ADMIN),
    distributorPriceController.updateDistributorPrices
);

export const distributorPriceRoutes = router;
