import { MessagingProvider } from "../../providers/messaging/MessagingProvider";
import { client } from "../../providers/prisma/client";
import { v4 as uuid } from 'uuid';


interface IPayloadNotification {
    plate: string;
    accessType: 'in' | 'out';
}

export class ReceivedRequestAccess {
    async execute({ plate, accessType }: IPayloadNotification) {
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
        const token = await client.accountToken.findFirst({
            where: {
                accountId: account.id
            }
        });

        if (!token) {
            return { status: 'Error', message: 'Token not found' }
        }

        const message = {
            notification: {
                title: 'Verificação de acesso!!',
                body: 'Detectamos que o veículo abaixo deseja entrar no estacionamento. Clique aqui e responda para abrir a cancela.'
            },
            data: {
                orderId:  new Date().getDate().toString(),
                orderDate: new Date().toISOString(), // '2021-08-21T18:02:00.000Z',
                accessType: accessType,
                plate: car.plate,
                model: car.model,
                manufacturer: car.manufacturer,
            },
            token: token?.token
        };
        const notificationProvider = new MessagingProvider();
        await notificationProvider.send(message);

        return { status: 'Success', message: 'Notification sent' }

    }
}