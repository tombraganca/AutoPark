import { prismaClient } from "../../providers/prisma/client";

interface IUpdateCarRequestDTO {
    plate: string;
    model: string;
    manufacturer: string;
    userid: string;
}

export class UpdateCarUseCase {
    async execute({ plate, manufacturer, model, userid }: IUpdateCarRequestDTO) {

        try {
            await this.validateOwner(userid, plate)

            const car = await prismaClient.car.update({
                where: {
                    plate
                },
                data: {
                    plate,
                    model,
                    manufacturer,
                }
            });
            return car;
        } catch (error: any) {
            throw new Error(error.message);
        }
    }

    //valida se o usuário é dono do carro
    async validateOwner(userid: string, plate: string) {
        const car = await prismaClient.car.findFirst({
            where: {
                plate
            }
        });

        if (car?.ownerId !== userid) {
            throw new Error("You are not the owner of this car");
        }
    }
}