import { Request, Response } from "express";
import { app, admin } from "../providers/firebase/config";

export default class Middleware {
    static async decodeToken(request: Request, response: Response, next: any) {
        const token = request.headers.authorization?.split(" ")[1];

        console.log(token)
        if (!token) {
            return response.status(401).json({
                message: "Token not found"
            });
        }

        try {
            
            const decodedToken = await admin.auth().verifyIdToken(token);

            if (decodedToken) {
                next();
            }

            response.status(401).json({
                message: "Invalid token"
            });


        } catch (error) {
            return response.status(401).json({
                message: "Invalid token"
            });
        }
    }
}