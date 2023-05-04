import { NextFunction, Request, Response } from "express";
import { verify } from "jsonwebtoken";



export default class AuthenticatedMiddleware {
    static async ensureAuthenticated(request: Request, response: Response, next: NextFunction) {
        const authToken = request.headers.authorization;

        if (!authToken) {
            return response.status(401).json({
                status: "Error",
                message: "Token is missing"
            });
        }

        const [, token] = authToken.split(" ");

        try {
            const decodedToken = verify(token, "fb4e6935-9de5-4d33-b256-e956ad5cf8a1");
            request.body.userid = decodedToken.sub;
            return next();
        } catch (error) {
            return response.status(401).json({
                status: "Error",
                message: "Token invalid"
            });
        }

    }
}