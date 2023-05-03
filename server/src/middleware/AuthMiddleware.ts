import { Request, Response } from "express";
import { admin } from "../providers/firebase/config";


export default class Middleware {
    static async decodeToken(request: Request, response: Response, next: any) {

        try {
            const token = request.headers.authorization?.split(" ")[1];
            if (!token) {
                return response.status(401).json({
                    message: "Token not found"
                });
            }

            const decodedToken = await admin.auth().verifyIdToken(token);

            if (!decodedToken.uid) {
                throw new Error("Invalid token");
            }

            request.body.uid = decodedToken.uid;
            next();

        } catch (error) {
            return response.status(401).json({
                message: "Invalid token"
            });
        }
    }
}