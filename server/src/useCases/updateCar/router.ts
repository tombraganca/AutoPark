import { Router } from "express";
import { UpdateCarController } from "./updateCarController";
import AuthenticatedMiddleware from "../../middleware/AuthMiddleware";

const router = Router();
const updateCarController = new UpdateCarController();

router.put("/car", AuthenticatedMiddleware.ensureAuthenticated ,updateCarController.handle);

export default router;