import express from 'express';
import publicRoutes from './services/public/routes';
import privateRoutes from './services/private/routes';

const router = express();

router.use(publicRoutes);
router.use(privateRoutes)

export default router;