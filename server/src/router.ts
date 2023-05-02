import express from 'express';
import AccountRouter from './services/public/Account/router';

const router = express();

router.use(AccountRouter);

export default router;