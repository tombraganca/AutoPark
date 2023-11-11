import { client } from "../../providers/prisma/client";
import MOCK_VACANCIES from "../../MOCK/vacancies.json";

interface ListVacanciesDTO {
    filter: "all" | "available";
    parkingId: string;
}
export class ListVacanciesUseCase {

    async execute(props: ListVacanciesDTO) {

        const situation = props.filter === 'all' ? null : 'free';

        try {
            // const vacancies = await client.vacancies.findMany({
            //     where: filter === 'all' ? {} : {
            //         situation
            //     }
            // });
            // return vacancies;
            return MOCK_VACANCIES.filter(v => {
                if (v.parkingId !== props.parkingId) return false;
                if (props.filter === 'all') return true;
                return v.situation === situation;
            });

        } catch (error: any) {
            throw new Error(error.message);
        }
    }
}