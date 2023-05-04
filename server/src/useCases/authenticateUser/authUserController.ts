import { Request, Response } from "express";
import { AuthUserUseCase } from "./authUserUseCase";

export class AuthUserController {
    async handle(request: Request, response: Response) {
        const { email, password } = request.body;

        const authUserUseCase = new AuthUserUseCase();

        const token = await authUserUseCase.execute({ email, password });

        return response.json(token);
    }

}