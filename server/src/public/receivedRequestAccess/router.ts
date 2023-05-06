import { Router } from "express";
import { ReceivedRequestAccessController } from "./ReceivedRequestAccessController";

const router = Router();
const receivedRequestAccessController = new ReceivedRequestAccessController();

router.post('/request-access', receivedRequestAccessController.handle);

export default router;