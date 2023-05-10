import { client } from "../../providers/prisma/client";

export class ListVacanciesUseCase {

    async execute() {
        return client.vacancies.findMany();
    }
}