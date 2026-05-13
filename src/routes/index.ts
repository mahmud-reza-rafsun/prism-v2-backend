import { Router } from "express";
import { authRoutes } from "../modules/auth/auth.route";
import { regionRoutes } from "../modules/region/region.route";
import { areaRoutes } from "../modules/area/area.route";

const router = Router();

router.use("/auth", authRoutes);
router.use("/region", regionRoutes)
router.use("/area", areaRoutes);

export const apiRoutes = router;
