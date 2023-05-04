import { Router } from 'express'
import { AuthUserController } from './authUserController';

const router = Router()
const authUserController = new AuthUserController()

router.post('/login', authUserController.handle)

export default router;