import { Router } from "express";
import { CreateAccessRegisterController } from "./CreateAccessRegisterController";
import AuthenticatedMiddleware from "../../middleware/AuthMiddleware";

const router = Router();
const createAccessRegisterController = new CreateAccessRegisterController();

router.post('/access', AuthenticatedMiddleware.ensureAuthenticated, createAccessRegisterController.handle);

export default router;