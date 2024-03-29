import { prismaClient } from "../../providers/prisma/client";
import { connectMqtt } from "../../providers/mqttProvider/mqttServer";

interface ICreateAccessRegisterRequestDTO {
    date: Date;
    accessType: string;
    plate: string;
    ownerId: string;
    parkingId: string;
}

export class CreateAccessRegisterUseCase {
    async execute({ date, accessType, plate, ownerId, parkingId }: ICreateAccessRegisterRequestDTO) {
        
        if (!date || !accessType || !plate) {
            throw new Error('Invalid data')
        }

        try {

            const accessRegister = await prismaClient.access.create({
                data: {
                    date,
                    type: accessType,
                    plate,
                    ownerId,
                    parkingId
                }
            });

            // Do Post in mqtt broker
            connectMqtt.send(`${parkingId}:open`);
            return accessRegister;
        } catch (error: any) {
            throw new Error(error.message);
        }
    }
}