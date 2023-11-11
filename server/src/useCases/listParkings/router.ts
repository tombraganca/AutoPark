import { Router } from "express";
import AuthenticatedMiddleware from "../../middleware/AuthMiddleware";
import { ListParkingsController } from "./ListParkingsController";

const router = Router();
const listParkingController = new ListParkingsController();

router.get("/parkings", AuthenticatedMiddleware.ensureAuthenticated, listParkingController.handle);

export default router;