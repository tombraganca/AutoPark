import { client } from "../../providers/prisma/client";

export class UpdateVacancyUseCase {
    execute({ id, title, description, type, situation }: any) {
        const vacancy = client.vacancies.update({
            where: {
                id
            },
            data: {
                title,
                description,
                type,
                situation
            }
        })
    }
}