import { Router } from 'express';
import AuthenticatedMiddleware from '../../middleware/AuthMiddleware';
import { ListVacanciesController } from './ListVacanciesController';

const router = Router();
const listVacanciesController = new ListVacanciesController();
router.get('/vacancies', AuthenticatedMiddleware.ensureAuthenticated, listVacanciesController.handle);

export default router;