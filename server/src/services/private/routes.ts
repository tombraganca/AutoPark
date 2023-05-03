import express from "express";
import CarRoutes from "./Car/router";
import Middleware from "../../middleware/AuthMiddleware";

const privateRoutes = express();

privateRoutes.use(Middleware.decodeToken, CarRoutes);

export default privateRoutes;