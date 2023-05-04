import { Request, Response } from "express";
import { CreateCarUseCase } from "./CreateCarUserCase";

export class CreateCarController {
    async handle(request: Request, response: Response) {
        const { plate, model, manufacturer, userid } = request.body;

        const createCarUseCase = new CreateCarUseCase();

        const car = await createCarUseCase.execute({ plate, model, manufacturer, ownerId: userid });

        return response.json(car);
    }
}