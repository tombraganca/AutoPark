import { Router } from "express";
import { RefreshTokenUserController } from "./RefreshTokenController";

const router = Router();
const refreshTokenUserController = new RefreshTokenUserController();

router.post("/refresh-token", refreshTokenUserController.handle);

export default router ;