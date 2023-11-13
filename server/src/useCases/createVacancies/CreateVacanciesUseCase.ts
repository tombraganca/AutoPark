import { prismaClient } from "../../providers/prisma/client";

interface IVacanciesProps {
    title: string;
    description?: string;
    type: 'normal' | 'deficient' | 'senior';
    situation: 'busy' | 'free' | 'alert';
    parkingId: string;

}

export class CreateVacanciesUseCase {

    async execute(props: IVacanciesProps) {
        const vacanciesCreated = await prismaClient.vacancies.create({
            data: {
                title: props.title,
                description: props.description || '',
                type: props.type,
                situation: props.situation,
                parkingId: props.parkingId
            }
        });
        return vacanciesCreated;
    }
}