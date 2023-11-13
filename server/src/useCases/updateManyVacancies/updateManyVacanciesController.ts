import { Request, Response } from "express";

export class UpdateManyVacanciesController {
    handle(request: Request, response: Response) {
        const { vacancies } = request.body;

        response.status(200).json({});
    }
}