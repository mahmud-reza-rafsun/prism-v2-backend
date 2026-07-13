import { Router } from "express";
import { distributionPoints } from "./distributionPoint.controller";

const router = Router();

router.post("/create-distribution-points/:distributionId", distributionPoints.createDistributionPoint);

export const distributionPointRoutes = router;