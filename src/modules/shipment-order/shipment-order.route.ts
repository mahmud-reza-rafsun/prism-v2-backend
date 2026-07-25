import { Router } from "express";
import { shipmentOrderController } from "./shipment-order.controller";
import { checkAuth } from "../../shared/middlewares/checkAuth";
import { Role } from "@prisma/client";

const router = Router();

router.post('/create/:dhId', checkAuth(Role.BUSINESS_MANAGER), shipmentOrderController.createShipmentOder);

export const shipmentOrderRoutes = router;
