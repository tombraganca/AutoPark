import { client } from "../../providers/prisma/client";

export class ListVacanciesUseCase {

    async execute(filter: 'all' | 'available') {

        //'busy' | 'free' | 'alert'
        const situation = filter === 'all' ? '' : 'available';

        try {
            const vacancies = await client.vacancies.findMany({
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