import { Router } from "express";
import { ListCarController } from "./ListCarController";
import AuthenticatedMiddleware from "../../middleware/AuthMiddleware";

const router = Router();
const listCarController = new ListCarController();

router.get("/car", AuthenticatedMiddleware.ensureAuthenticated, listCarController.handle);

export default router;