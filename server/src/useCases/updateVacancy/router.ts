import { Router } from "express";
import { UpdateVacancyController } from "./UpdateVacancyController";

const router = Router();
const updateVacancyController = new UpdateVacancyController();

router.put("/vacancy/:id", updateVacancyController.handle);