import express from 'express';
import AccountRouter from './Account/router';

const publicRoutes = express();

publicRoutes.use(AccountRouter);

export default publicRoutes;