import express from "express";
import CarRoutes from "./Car/router";
import AccessRoutes from "./Access/router";
import Middleware from "../../middleware/AuthMiddleware";

const privateRoutes = express();

privateRoutes.use(Middleware.decodeToken, CarRoutes);
privateRoutes.use(Middleware.decodeToken, AccessRoutes)

export default privateRoutes;