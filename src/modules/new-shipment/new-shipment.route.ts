
import { Role } from "@prisma/client";
import { newShipmentController } from "./new-shipment.controller";
import { Router } from "express";
import { checkAuth } from "../../shared/middlewares/checkAuth";

const router = Router();

// Create New Shipment
router.post(
    "/add-new/:distributionHouseId",
    checkAuth(Role.BUSINESS_MANAGER, Role.SUPER_ADMIN),
    newShipmentController.createNewShipment
);

// Get All New Shipments
router.get(
    "/get-all/:distributionHouseId",
    checkAuth(Role.BUSINESS_MANAGER, Role.SUPER_ADMIN),
    newShipmentController.getShipmentsByDistributionHouse
);

export const newShipmentRoutes = router;
