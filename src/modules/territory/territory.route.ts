import { Router } from "express";
import { Role } from "@prisma/client";
import { checkAuth } from "../../shared/middlewares/checkAuth";
import { territoryController } from "./territory.controller";

const router = Router();

router.get(
    "/get-all-territory",
    checkAuth(Role.SUPER_ADMIN),
    territoryController.getAllTerritory
);

router.post(
    "/create-territory/:distributionId",
    checkAuth(Role.SUPER_ADMIN),
    territoryController.createTerritory
);

export const territoryRoutes = router;