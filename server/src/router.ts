import express from 'express';
import authUserRouter from "./useCases/authenticateUser/router";
import createUserRouter from "./useCases/creareUser/router";
import createCarRouter from "./useCases/createCar/router";
import listCarRouter from "./useCases/listCar/router";
import refreshTokenRouter from "./useCases/refreshTokenUser/router";
import pushNotificationRouter from "./useCases/pushNotification/router";
import createTokenUser from "./useCases/createTokenUser/router";
import receivedRequestAccessRouter from "./public/receivedRequestAccess/router"
import createAccessRegisterRouter from "./useCases/createAccessRegister/router";
import listVacanciesRouter from "./useCases/listVacancies/router";
import createVacancyRouter from "./useCases/createVacancies/router";
import listRegistersRouter from "./useCases/listRegisters/router"
import createBusinessRouter from "./useCases/createBusiness/router";

const router = express();

router.use(createUserRouter);
router.use(authUserRouter);
router.use(createCarRouter);
router.use(listCarRouter);
router.use(refreshTokenRouter);
router.use(pushNotificationRouter);
router.use(createTokenUser);
router.use(receivedRequestAccessRouter);
router.use(createAccessRegisterRouter);
router.use(listVacanciesRouter);
router.use(createVacancyRouter);
router.use(listRegistersRouter);
router.use(createBusinessRouter);

export default router;