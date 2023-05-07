import { client } from "../../providers/prisma/client";

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

            return accessRegister;
        } catch (error: any) {
            throw new Error(error.message);
        }
    }
}