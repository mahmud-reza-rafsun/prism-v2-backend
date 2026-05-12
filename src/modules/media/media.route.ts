import { Role } from "@prisma/client";

import { Router } from "express";
import { mediaController } from "./media.controller";
import { checkAuth } from "../../shared/middlewares/checkAuth";

const router = Router();

router.get(
  "/:publicId/transform",
  checkAuth(Role.ADMIN, Role.USER),
  mediaController.signMedia,
);
router.post(
  "/upload/presign",
  checkAuth(Role.ADMIN, Role.USER),
  mediaController.createPresign,
);
router.post(
  "/upload/delete",
  checkAuth(Role.ADMIN, Role.USER),
  mediaController.deleteUploads,
);

export const mediaRoutes = router;
