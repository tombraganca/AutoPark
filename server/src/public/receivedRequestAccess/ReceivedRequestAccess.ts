import { MessagingProvider } from "../../providers/messaging/MessagingProvider";
import { prismaClient } from "../../providers/prisma/client";
import { Car } from '@prisma/client'


interface IPayloadNotification {
    plateIds: Array<string>;
    accessType: 'in' | 'out';
    parkingId: string;
}

export class ReceivedRequestAccess {
    async execute({ plateIds, accessType, parkingId  }: IPayloadNotification) {

        const car = await this.findCar(plateIds);

        const lastAccess = await prismaClient.access.findFirst({
            where: {
                plate: car.plate
            },
            orderBy: {
                date: 'desc'
            }
        });

        if (lastAccess?.type === 'in' && accessType === 'in') {
            console.error('Car already inside')
            return { status: 'Error', message: 'Car already inside' };
        }

        if (lastAccess?.type === 'out' && accessType === 'out') {
            console.error('Car already outside')
            return { status: 'Error', message: 'Car already outside' };
        }

        const account = await prismaClient.account.findFirst({
            where: {
                id: car.ownerId
            }
        });

        if (!account) {
            return { status: 'Error', message: 'User not found' };
        }

        //encontrar o token do dono do carro
        const token = await prismaClient.accountToken.findFirst({
            where: {
                accountId: account.id
            }
        });

        if (!token) {
            return { status: 'Error', message: 'Token not found' };
        }

        await this.sendNotification(accessType, car, parkingId, token.token);

        return { status: 'Success', message: 'Notification sent' }
    }

    async findCar(plateIds: Array<string>): Promise<Car>{

        let car;
        for (let plate of plateIds) {
            car = await prismaClient.car.findFirst({
                where: {
                    plate: plate
                }
            });
        }

        if (!car) {
            throw new Error('Car not found');
        }

        return car;
    }

    async sendNotification(accessType: 'in' | 'out', car: Car, parkingId: string, token: string) {
        const message = {
            notification: {
                title: 'Verificação de acesso!!',
                body: 'Detectamos que o veículo abaixo deseja entrar no estacionamento. Clique aqui e responda para abrir a cancela.'
            },
            data: {
                orderId: new Date().getDate().toString(),
                orderDate: new Date().toISOString(), // '2021-08-21T18:02:00.000Z',
                accessType: accessType,
                plate: car.plate,
                model: car.model,
                manufacturer: car.manufacturer,
                parkingId
            },
            token: token
        };
        const notificationProvider = new MessagingProvider();
        await notificationProvider.send(message);
    }
}