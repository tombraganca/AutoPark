import { Router } from 'express';
import { CreateVacanciesController } from './CreateVacanciesController';

const router = Router();
const createVacanciesController = new CreateVacanciesController();

router.post('/vacancies', createVacanciesController.handle);

export default router;