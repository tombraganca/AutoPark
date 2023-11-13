import { Request, Response } from "express";
import { UpdateCarUseCase } from "./updateCarUseCase";

export class UpdateCarController {
    async handle(request: Request, response: Response) {
        try {
            const { plate, model, manufacturer, userid } = request.body;

            const updateCarUseCase = new UpdateCarUseCase();
            const car = await updateCarUseCase.execute({ plate, model, manufacturer, userid });

            return response.json(car);
        }
        catch (error: any) {
            return response.status(400).json({ error: error.message });
        }
    }
}