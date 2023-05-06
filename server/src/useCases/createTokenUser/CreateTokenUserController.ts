import { Request, Response } from "express";
import { CreateTokenUserUseCase } from "./CreateTokenUserUseCase";

export class CreateTokenUserController {
    async handle(request: Request, response: Response) {
        const { userid, token } = request.body;

        const createTokenUserUseCase = new CreateTokenUserUseCase();

        const result = await createTokenUserUseCase.execute({ accountId: userid, token });

        return response.status(201).json(result);
    }
}