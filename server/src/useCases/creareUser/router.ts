import { Router } from 'express';
import { CreateUserController } from './createUserUseController';

const router = Router();

const createUserController = new CreateUserController();

router.post("/signup", createUserController.handle);

export default router;