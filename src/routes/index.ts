import { Router } from "express";
import { authRoutes } from "../modules/auth/auth.route";
import { regionRoutes } from "../modules/region/region.route";
import { areaRoutes } from "../modules/area/area.route";
import { distributionRoutes } from "../modules/distribution/distribution.route";
import { territoryRoutes } from "../modules/territory/territory.route";

const router = Router();

router.use("/auth", authRoutes);
router.use("/region", regionRoutes)
router.use("/area", areaRoutes);
router.use("/distribution", distributionRoutes);
router.use("/territory", territoryRoutes);

export const apiRoutes = router;
