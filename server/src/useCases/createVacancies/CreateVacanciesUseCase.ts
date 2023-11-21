import { prismaClient } from "../../providers/prisma/client";

interface IVacanciesProps {
    title: string;
    description?: string;
    type: 'normal' | 'deficient' | 'senior';
    situation: 'busy' | 'free' | 'alert';
    parkingId: string;
    section?: number;
    center?: { x: number, y: number };

}

export class CreateVacanciesUseCase {

    async execute(props: IVacanciesProps) {
        try {
            const vacanciesCreated = await prismaClient.vacancies.create({
                data: {
                    title: props.title,
                    description: props.description || '',
                    type: props.type,
                    situation: props.situation,
                    center: props.center,
                    parkingId: props.parkingId,
                    section: props.section,
                }
            });
            return vacanciesCreated;
        } catch (error: any) {
            throw new Error(error.message);
        }
    }
}