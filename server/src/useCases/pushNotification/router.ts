import { Router } from "express";
import { PushNotificationController } from "./PushNoticicationController";

const router = Router();
const pushNotificationController = new PushNotificationController();

router.post('/push-notification', pushNotificationController.handle);

export default router;