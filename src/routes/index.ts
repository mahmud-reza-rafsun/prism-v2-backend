import { Router } from "express";
import { authRoutes } from "../modules/auth/auth.route";
import { regionRoutes } from "../modules/region/region.route";
import { areaRoutes } from "../modules/area/area.route";
import { distributionRoutes } from "../modules/distribution/distribution.route";
import { territoryRoutes } from "../modules/territory/territory.route";
import { distributionPointRoutes } from "../modules/distributionPoint/distributionPoint.route";
import { outletRoutes } from "../modules/outlet/outlet.route";

const router = Router();

router.use("/auth", authRoutes);
router.use("/region", regionRoutes)
router.use("/area", areaRoutes);
router.use("/territory", territoryRoutes);
router.use("/distribution", distributionRoutes);
router.use("/distribution-point", distributionPointRoutes);
router.use("/create-outlet", outletRoutes);

export const apiRoutes = router;
