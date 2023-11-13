import { prismaClient } from "../../providers/prisma/client";

export class UpdateVacancyUseCase {
    async execute({ title, description, type, situation }: any) {
        const vacancy = await prismaClient.vacancies.update({
            where: {
                title
            },
            data: {
                title,
                description,
                type,
                situation
            }
        });

        return vacancy;
    }
}