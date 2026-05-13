import { Router } from "express";
import { authRoutes } from "../modules/auth/auth.route";
import { regionRoutes } from "../modules/region/region.route";

const router = Router();

router.use("/auth", authRoutes);
router.use("/region", regionRoutes)

export const apiRoutes = router;
