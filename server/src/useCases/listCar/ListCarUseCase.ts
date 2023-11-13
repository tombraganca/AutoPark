import { prismaClient } from './../../providers/prisma/client'


export class ListCarUseCase {
    async execute(userId: string) {

        if (!userId) {
            throw new Error("Missing information");
        }

        const cars = await prismaClient.car.findMany({
            where: {
                ownerId: userId
            }
        })

        return cars
    }
}