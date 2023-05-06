import { Request, Response } from "express";
import { ReceivedRequestAccess } from "./ReceivedRequestAccess";

export class ReceivedRequestAccessController {
    async handle(request: Request, response: Response) {
        const { plate, accessType } = request.body;

        const receivedRequestUseCase = new ReceivedRequestAccess();
        const result = await receivedRequestUseCase.execute({ plate, accessType });

        return response.status(201).json(result);
    }
}
//365214