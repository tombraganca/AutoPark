import { FastifyInstance } from "fastify";
import { createUser } from "./UserController";



export const setUserRoutes = (router: FastifyInstance) => {
    router.post("/users", createUser);
};



export default setUserRoutes;
