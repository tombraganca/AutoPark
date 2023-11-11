import { Request, Response } from "express";
import { ListParkingsUseCase } from "./ListParkingsUseCase";

export class ListParkingsController {
    async handle(request: Request, response: Response) {
        const { filter } = request.query;
        if(typeof filter !== "string") {
            return response.status(400).json({ error: "Invalid filter" });
        }
        const listVacanciesUseCase = new ListParkingsUseCase();
        const vacancies = await listVacanciesUseCase.execute(filter);
        return response.json(vacancies);
    }
}