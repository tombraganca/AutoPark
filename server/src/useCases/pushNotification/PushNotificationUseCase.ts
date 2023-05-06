import { MessagingProvider } from "../../providers/messaging/MessagingProvider";
import { client } from "../../providers/prisma/client";

interface IPayloadNotification {
    body: {
        accessType: 'in' | 'out';
        plate: string;
        date: string;
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
                    title: 'Solicitação de novo acesso',
                    body: 'Uma nova solicitação de acesso foi realizada.'
                },
                data: {
                    orderId: '123456',
                    orderDate: '2021-09-01',
                    accessType: body.accessType,
                    plate: body.plate,
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