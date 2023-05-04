import { Router } from "express";
import { CreateCarController } from "./CreateCarController";
import AuthenticatedMiddleware from "../../middleware/AuthMiddleware";

const router = Router();
const createCarController = new CreateCarController();

router.post("/car", AuthenticatedMiddleware.ensureAuthenticated, createCarController.handle);

export default router;

