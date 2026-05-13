import { Router } from "express";
import { regionController } from "./region.controller";
import { Role } from "@prisma/client";
import { checkAuth } from "../../shared/middlewares/checkAuth";

const router = Router();

router.post(
    "/create-regions",
    checkAuth(Role.SUPER_ADMIN),
    regionController.createRegion
);

export const regionRoutes = router;