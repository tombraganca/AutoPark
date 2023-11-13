import { prismaClient } from "../../providers/prisma/client";
import MOCK_VACANCIES from "../../mock/vacancies.json";

interface ListVacanciesDTO {
    filter: "all" | "available";
    parkingId: string;
}

enum VacancySituation {
    FREE = 'free',
    OCCUPIED = 'busy',
    RESERVED = 'reservation',
    ALERT = 'alert'
}
export class ListVacanciesUseCase {

    async execute({ filter, parkingId }: ListVacanciesDTO) {

        const situation = this.defineVacancySituation(filter);

        try {
            const vacancies = await prismaClient.vacancies.findMany({
                where: {
                    parkingId: parkingId,
                    situation
                }
            });
            return vacancies;

        } catch (error: any) {
            throw new Error(error.message);
        }
    }

    defineVacancySituation(filter: "all" | "available" | "reservation"): VacancySituation | null {
        switch (filter) {
            case "all":
                return null;
            case "available":
                return VacancySituation.FREE;
            case "reservation":
                return VacancySituation.RESERVED;
            default:
                return null;
        }
    }

}