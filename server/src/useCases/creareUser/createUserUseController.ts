import { Request, Response } from "express";
import { CreateUserUserCase } from "./createUserCase";

export class CreateUserController {

    async handle(request: Request, response: Response) {
        const { email, password, name } = request.body;

        const createUserUseCase = new CreateUserUserCase();

        const user = await createUserUseCase.execute({ email, password, name });

        return response.json(user);
    }
}