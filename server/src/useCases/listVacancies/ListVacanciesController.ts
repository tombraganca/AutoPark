import { Request, Response } from "express";
import { ListVacanciesUseCase } from "./ListVacanciesUseCase";

export class ListVacanciesController {
    async handle(request: Request, response: Response) {
        try {
            const { filter, parkingId } = request.query;

            if (typeof filter !== "string" || typeof parkingId !== "string") {
                return response.status(400).json({ error: "Invalid filter" });
            }
            const listVacanciesUseCase = new ListVacanciesUseCase;
            const exclusiveFilters = filter === `all` ? filter : `available`;
            const vacancies = await listVacanciesUseCase.execute({ filter: exclusiveFilters, parkingId });
            return response.json(vacancies);
        }
        catch (error: any) {
            return response.status(400).json({ error: error.message });
        }
    }
}