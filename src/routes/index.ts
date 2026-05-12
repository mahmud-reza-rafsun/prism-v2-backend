import { Router } from "express";
import { authRoutes } from "../modules/auth/auth.route";
import { regionRoute } from "../modules/region/region.route";

const router = Router();

router.use("/auth", authRoutes);
router.use("/regions", regionRoute)

export const apiRoutes = router;
