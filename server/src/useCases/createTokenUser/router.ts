import { Router } from 'express';
import { CreateTokenUserController } from './CreateTokenUserController';
import AuthenticatedMiddleware from '../../middleware/AuthMiddleware';

const router = Router();
const createTokenUserController = new CreateTokenUserController();

router.post('/token', AuthenticatedMiddleware.ensureAuthenticated, createTokenUserController.handle);

export default router;