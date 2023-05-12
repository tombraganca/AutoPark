import { Request, Response } from "express";
import { ListVacanciesUseCase } from "./ListVacanciesUseCase";

export class ListVacanciesController {
    async handle(request: Request, response: Response) {
        const { filter } = request.params
        const listVacanciesUseCase = new ListVacanciesUseCase;
        const vacancies = await listVacanciesUseCase.execute(filter !== 'all' ? 'available' : 'all');
        return response.json(vacancies);
    }
}