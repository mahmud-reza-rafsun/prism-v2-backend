import { Router } from "express";
import { shipmentOrderController } from "./shipment-order.controller";
import { checkAuth } from "../../shared/middlewares/checkAuth";
import { Role } from "@prisma/client";

const router = Router();

router.post('/create-shipment-orders', checkAuth(Role.BUSINESS_MANAGER), shipmentOrderController.createShipmentOder);
router.get('/get-all-shipment-orders', checkAuth(Role.BUSINESS_MANAGER, Role.TERRITORY_OFFICER), shipmentOrderController.getShipmentOrdersByDate);



export const shipmentOrderRoutes = router;
