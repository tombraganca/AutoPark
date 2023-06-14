import { Router } from "express";
import AuthenticatedMiddleware from "../../middleware/AuthMiddleware";
import ListRegisterController from "./ListRegisterController";

const router = Router();
const listCarController = new ListRegisterController();

router.get("/car", AuthenticatedMiddleware.ensureAuthenticated, listCarController.handle);

export default router;