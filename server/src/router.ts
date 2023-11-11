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
import createParkingRouter from "./useCases/createParking/router";
import listParkingsRouter from "./useCases/listParkings/router";

const router = express();

router.use(authUserRouter);
router.use(createUserRouter);
router.use(createCarRouter);
router.use(createTokenUser);
router.use(createAccessRegisterRouter);
router.use(createVacancyRouter);
router.use(createParkingRouter);
router.use(listCarRouter);
router.use(listVacanciesRouter);
router.use(listRegistersRouter);
router.use(listParkingsRouter)
router.use(pushNotificationRouter);
router.use(refreshTokenRouter);
router.use(receivedRequestAccessRouter);

export default router;