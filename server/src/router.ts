import express from 'express';
import authUserRouter from "./useCases/authenticateUser/router";
import createUserRouter from "./useCases/creareUser/router";
import createCarRouter from "./useCases/createCar/router";
import listCarRouter from "./useCases/listCar/router";
import refreshTokenRouter from "./useCases/refreshTokenUser/router";
import pushNotificationRouter from "./useCases/pushNotification/router";
const router = express();

router.use(createUserRouter);
router.use(authUserRouter);
router.use(createCarRouter);
router.use(listCarRouter);
router.use(refreshTokenRouter)
router.use(pushNotificationRouter)

export default router;