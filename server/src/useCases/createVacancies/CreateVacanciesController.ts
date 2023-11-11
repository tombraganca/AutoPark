import { Request, Response } from "express";
import { CreateVacanciesUseCase } from "./CreateVacanciesUseCase";

export class CreateVacanciesController {
    async handle(request: Request, response: Response) {
        const { title, description, type, situation, businessId } = request.body;

        if (!title || !type || !situation) {
            throw new Error("Missing params");
        }

        const createVacanciesUseCase = new CreateVacanciesUseCase();
        const vacancies = await createVacanciesUseCase.execute({
            title,
            description,
            type,
            situation,
            parkingId: businessId
        });
        return response.json(vacancies);
    }
}