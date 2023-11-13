import { prismaClient } from "../../providers/prisma/client"

interface iCarRequest {
    model: string
    manufacturer: string
    plate: string
    ownerId: string
}

export class CreateCarUseCase {
    async execute(props: iCarRequest) {
        const { model, manufacturer, plate, ownerId } = props

        if (!model || !manufacturer || !plate || !ownerId) {
            throw new Error("Missing information");
        }

        const carAlreadyExists = await prismaClient.car.findFirst({
            where: {
                plate
            }
        });

        if (carAlreadyExists) {
            throw new Error("Car already exists");
        }

        const car = await prismaClient.car.create({
            data: {
                model,
                manufacturer,
                plate,
                ownerId
            }
        });

        return car;
    }
}