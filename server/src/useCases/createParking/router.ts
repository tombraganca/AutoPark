import { Router } from "express";
import AuthenticatedMiddleware from "../../middleware/AuthMiddleware";
import { CreateParkingController } from './CreateParkingController'


const router = Router();
const createParkingController = new CreateParkingController();
router.post("/parkings", AuthenticatedMiddleware.ensureAuthenticated, createParkingController.handle);

export default router;

