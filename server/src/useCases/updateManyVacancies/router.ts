import { Router } from "express";
import { UpdateManyVacanciesController } from "./updateManyVacanciesController";

const router = Router();
const updateManyVacanciesController = new UpdateManyVacanciesController();

router.patch("/vacancies", updateManyVacanciesController.handle);