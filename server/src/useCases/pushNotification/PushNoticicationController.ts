import { Request, Response } from "express";
import { PushNotificationUseCase } from "./PushNotificationUseCase";

export class PushNotificationController {
    async handle(request: Request, response: Response) {
        const { body, token, userid } = request.body;

        if (!body || !token) {
            return response.status(400).json({
                message: 'Missing body or token'
            });
        }

        const pushNotificationUseCase = new PushNotificationUseCase();
        const result = await pushNotificationUseCase.execute({ body, token, accoundId: userid });

        return response.json(result);
    }
}