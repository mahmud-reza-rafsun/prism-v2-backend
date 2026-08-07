import { Router } from "express";
import { authRoutes } from "../modules/auth/auth.route";
import { regionRoutes } from "../modules/region/region.route";
import { areaRoutes } from "../modules/area/area.route";
import { distributionRoutes } from "../modules/distribution/distribution.route";
import { territoryRoutes } from "../modules/territory/territory.route";
import { distributionPointRoutes } from "../modules/distributionPoint/distributionPoint.route";
import { outletRoutes } from "../modules/outlet/outlet.route";
import { shipmentOrderRoutes } from "../modules/shipment-order/shipment-order.route";
import { distributorPriceRoutes } from "../modules/distributorPrice/distributorPrice.route";
import { newShipmentRoutes } from "../modules/new-shipment/new-shipment.route";

const router = Router();

router.use("/auth", authRoutes);
router.use("/region", regionRoutes)
router.use("/area", areaRoutes);
router.use("/territory", territoryRoutes);
router.use("/distribution", distributionRoutes);
router.use("/distribution-point", distributionPointRoutes);
router.use("/create-outlet", outletRoutes);
router.use("/shipment", shipmentOrderRoutes);
router.use("/distributor-price", distributorPriceRoutes);
router.use("/new-shipment", newShipmentRoutes);

export const apiRoutes = router;
