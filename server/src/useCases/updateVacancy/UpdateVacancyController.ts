import { Request, Response } from "express";
import { UpdateVacancyUseCase } from "./UpdateVacancyUseCase";

export class UpdateVacancyController {
    async handle(request: Request, response: Response) {
        const { title, description, type, situation } = request.body;

        const updateVacancyUseCase = new UpdateVacancyUseCase();
        const vacancy = await updateVacancyUseCase.execute({ title, description, type, situation });

        return response.status(200).json(vacancy);
    }
}