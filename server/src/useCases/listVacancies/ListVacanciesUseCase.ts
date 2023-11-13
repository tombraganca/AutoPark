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
            // const vacancier = await client.vacancies.findMany({
            //     where: {
            //         parkingId: props.parkingId,
            //         situation: props.filter === 'all' ? undefined : situation
            //     }
            // });
            const vacancies = await prismaClient.vacancies.findMany({
                where: filter === 'all' ? {} : {
                    situation
                }
            });
            return vacancies;

        } catch (error: any) {
            throw new Error(error.message);
        }
    }
}