import { MessagingProvider } from "../../providers/messaging/MessagingProvider";
import { client } from "../../providers/prisma/client";
import { v4 as uuid } from 'uuid';

interface IPayloadNotification {
    body: {
        accessType: 'in' | 'out';
        plate: string;
        date: string;
        model: string;
        manufacturer: string;
    }
    token: string;
    accoundId: string;
}
export class PushNotificationUseCase {
    async execute({ body, token, accoundId }: IPayloadNotification) {

        try {
            const car = await client.car.findFirst({
                where: {
                    plate: body.plate
                }
            });

            if (!car) {
                return { status: 'Error', message: 'Car not found' }
            }

            const account = await client.account.findFirst({
                where: {
                    id: accoundId
                }
            });

            if (!account) {
                return { status: 'Error', message: 'User not found' }
            }

            // se o carro é do usuário
            if (car.ownerId !== account.id) {
                return { status: 'Error', message: 'Car not found' }
            }

            const message = {
                notification: {
                    title: 'Verificação de acesso!!',
                    body: 'Detectamos que o veículo abaixxo deseja entrar no estacionamento. Clique aqui e responda para abrir a cancela.'
                },
                data: {
                    orderId: uuid(),
                    orderDate: new Date().toISOString(), // '2021-08-21T18:02:00.000Z',
                    accessType: body.accessType,
                    plate: body.plate,
                    model: body.model,
                    manufacturer: body.manufacturer,
                },
                token: token
            };

            const messagingProvider = new MessagingProvider();
            const result = await messagingProvider.send(message);

            return result;
        } catch (error) {
            console.error(error);
            return { status: 'Error', message: 'Internal server error' }
        }

    }
}