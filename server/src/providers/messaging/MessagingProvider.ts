import { Message } from "firebase-admin/lib/messaging/messaging-api";
import { admin } from "../firebase/config";

interface IPayload {
    notification: {
        title: string;
        body: string;
    };
    data: {
        orderId: string;
        orderDate: string;
        accessType: 'in' | 'out';
        plate: string;
        model: string;
        manufacturer: string;
        parkingId: string;
    };

    token: string;
}
export class MessagingProvider {
    async send(payload: IPayload): Promise<string> {
        return await admin.messaging().send(payload);
    }
}