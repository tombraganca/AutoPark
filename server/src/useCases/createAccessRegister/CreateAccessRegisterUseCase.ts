import { client } from "../../providers/prisma/client";
import { connectMqtt } from "../../providers/mqttProvider/mqttServer";

interface ICreateAccessRegisterRequestDTO {
    date: Date;
    accessType: string;
    plate: string;
    ownerId: string;
}

export class CreateAccessRegisterUseCase {
    async execute({ date, accessType, plate, ownerId }: ICreateAccessRegisterRequestDTO) {
        if (!date || !accessType || !plate) {
            throw new Error('Invalid data')
        }

        try {

            const accessRegister = await client.access.create({
                data: {
                    date,
                    type: accessType,
                    plate,
                    ownerId
                }
            });

            // Do Post in mqtt broker
            connectMqtt.send('open');
            return accessRegister;
        } catch (error: any) {
            throw new Error(error.message);
        }
    }
}