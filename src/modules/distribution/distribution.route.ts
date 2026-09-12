import { Router } from "express";
import { Role } from "@prisma/client";
import { checkAuth } from "../../shared/middlewares/checkAuth";
import { distributionController } from "./distribution.controller";

const router = Router();

router.get(
    "/get-all-distributions/",
    checkAuth(Role.SUPER_ADMIN),
    distributionController.getAllDistribution
);

router.post(
    "/create-distributions/:areaId",
    checkAuth(Role.SUPER_ADMIN),
    distributionController.createDistribution
);

export const distributionRoutes = router;