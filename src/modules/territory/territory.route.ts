import { Router } from "express";
import { Role } from "@prisma/client";
import { checkAuth } from "../../shared/middlewares/checkAuth";
import { territoryController } from "./territory.controller";

const router = Router();

router.post(
    "/create-territory",
    checkAuth(Role.SUPER_ADMIN),
    territoryController.createTerritory
);

export const regionRoutes = router;