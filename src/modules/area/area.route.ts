// modules/area/area.route.ts
import { Router } from "express";
import { Role } from "@prisma/client";
import { checkAuth } from "../../shared/middlewares/checkAuth";
import { areaController } from "./area.controller";

const router = Router();

router.post(
    "/create-area/:regionId",
    checkAuth(Role.SUPER_ADMIN),
    areaController.createArea
);

export const areaRoutes = router;