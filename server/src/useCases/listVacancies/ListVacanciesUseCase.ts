import { prismaClient } from "../../providers/prisma/client";
import MOCK_VACANCIES from "../../mock/vacancies.json";

interface ListVacanciesDTO {
    filter: "all" | "available";
    parkingId: string;
}
export class ListVacanciesUseCase {

    async execute({ filter, parkingId }: ListVacanciesDTO) {

        const situation = filter === 'all' ? null : 'free';

        try {
            const vacancies = await prismaClient.vacancies.findMany({
                where: {
                    parkingId: parkingId,
                    situation: filter === 'all' ? {} : situation
                }
            });
            return vacancies;

        } catch (error: any) {
            throw new Error(error.message);
        }
    }
}