import express from 'express';

import receivedRequestAccessRouter from './public/receivedRequestAccess/router';
import authUserRouter from './useCases/authenticateUser/router';
import createUserRouter from './useCases/creareUser/router';
import createAccessRegisterRouter from './useCases/createAccessRegister/router';
import createCarRouter from './useCases/createCar/router';
import createParkingRouter from './useCases/createParking/router';
import createTokenUser from './useCases/createTokenUser/router';
import createVacancyRouter from './useCases/createVacancies/router';
import listCarRouter from './useCases/listCar/router';
import listParkingsRouter from './useCases/listParkings/router';
import listRegistersRouter from './useCases/listRegisters/router';
import listVacanciesRouter from './useCases/listVacancies/router';
import pushNotificationRouter from './useCases/pushNotification/router';
import refreshTokenRouter from './useCases/refreshTokenUser/router';
import updateCarRouter from './useCases/updateCar/router';

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
router.use(updateCarRouter);

export default router;