import { Request, Response } from "express";
import { ListVacanciesUseCase } from "./ListVacanciesUseCase";

export class ListVacanciesController {
    async handle(request: Request, response: Response) {
        const listVacanciesUseCase = new ListVacanciesUseCase;
        const vacancies = await listVacanciesUseCase.execute();
        return response.json(vacancies);
    }
}