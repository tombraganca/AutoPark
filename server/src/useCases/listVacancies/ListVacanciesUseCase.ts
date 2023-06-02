import { client } from "../../providers/prisma/client";
import MOCK_VACANCIES from "../../MOCK/vacancies.json";

export class ListVacanciesUseCase {

    async execute(filter: 'all' | 'available') {

        const situation = filter === 'all' ? null : 'free';

        try {
            // const vacancies = await client.vacancies.findMany({
            //     where: filter === 'all' ? {} : {
            //         situation
            //     }
            // });
            // return vacancies;
            return MOCK_VACANCIES.filter(v => {
                if (filter === 'all') return true;
                return v.situation === situation;
            });

        } catch (error: any) {
            throw new Error(error.message);
        }
    }
}