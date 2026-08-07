import { Router } from "express";
import { shipmentOrderController } from "./shipment-order.controller";
import { checkAuth } from "../../shared/middlewares/checkAuth";
import { Role } from "@prisma/client";

const router = Router();

router.post('/create-shipment-orders/:distributionHouseId', checkAuth(Role.BUSINESS_MANAGER, Role.SUPER_ADMIN), shipmentOrderController.createShipmentOder);

router.get(
    "/all-orders/:distributionHouseId",
    checkAuth(Role.SUPER_ADMIN, Role.BUSINESS_MANAGER, Role.FG_SUPERVISOR),
    shipmentOrderController.getAllShipmentOrders
);

router.get(
    "/order-get/by-date/:distributionHouseId/:date",
    checkAuth(Role.SUPER_ADMIN, Role.FG_SUPERVISOR),
    shipmentOrderController.getShipmentOrdersByDate
);

export const shipmentOrderRoutes = router;
