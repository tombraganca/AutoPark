import { client } from "../../providers/prisma/client";
import { connectMqtt } from "../../providers/mqttProvider/server";

interface ICreateAccessRegisterRequestDTO {
    date: Date;
    accessType: string;
    plate: string;
}

export class CreateAccessRegisterUseCase {
    async execute({ date, accessType, plate }: ICreateAccessRegisterRequestDTO) {
        if (!date || !accessType || !plate) {
            throw new Error('Invalid data')
        }

        try {

            const accessRegister = await client.access.create({
                data: {
                    date,
                    type: accessType,
                    plate
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