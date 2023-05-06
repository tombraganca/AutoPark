import { client } from "../../providers/prisma/client";

export class ReceivedAccess {
    async execute(plate: string) {
        ///encontrar o dono do carro
        const car = await client.car.findFirst({
            where: {
                plate: plate
            }
        });

        if (!car) {
            return { status: 'Error', message: 'Car not found' }
        }

        const account = await client.account.findFirst({
            where: {
                id: car.ownerId
            }
        });

        if (!account) {
            return { status: 'Error', message: 'User not found' }
        }

        ///encontrar o token do dono do carro

        
        ///enviar a notificação para o token
        ///salvar o acesso no banco de dados

    }
}