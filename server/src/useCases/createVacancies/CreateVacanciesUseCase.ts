import { client } from "../../providers/prisma/client";

interface IVacanciesProps {
    title: string;
    description?: string;
    type: 'normal' | 'deficient' | 'senior';
    situation: 'busy' | 'free' | 'alert';

}

export class CreateVacanciesUseCase {

    async execute(props: IVacanciesProps) {
        const vacanciesCreated = await client.vacancies.create({
            data: {
                title: props.title,
                description: props.description || '',
                type: props.type,
                situation: props.situation
            }
        });
        return vacanciesCreated;
    }
}