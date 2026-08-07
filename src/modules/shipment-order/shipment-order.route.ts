import { Router } from "express";
import { shipmentOrderController } from "./shipment-order.controller";
import { checkAuth } from "../../shared/middlewares/checkAuth";
import { Role } from "@prisma/client";

const router = Router();

router.post('/create-shipment-orders', checkAuth(Role.BUSINESS_MANAGER, Role.SUPER_ADMIN), shipmentOrderController.createShipmentOder);
router.get('/get-all-shipment-orders', checkAuth(Role.BUSINESS_MANAGER, Role.SUPER_ADMIN, Role.TERRITORY_OFFICER, Role.FG_SUPERVISOR), shipmentOrderController.getShipmentOrdersByDate);
router.use("/get-shipment-order-sku", checkAuth(Role.BUSINESS_MANAGER, Role.SUPER_ADMIN, Role.TERRITORY_OFFICER, Role.FG_SUPERVISOR), shipmentOrderController.getShipmentOrdersSku);

export const shipmentOrderRoutes = router;
