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
    };

    token: string;
}
export class MessagingProvider {
    async send(payload: IPayload): Promise<string> {
        payload.token = "cSC5pcvZQ7OkCJMuy-XS0v:APA91bFE4BMjtxPcjkAe_1PTWlhzHmLQE79_RvrBF_tUY8GQQiqQhEL7Dp8CMIdaQ0VFJT5Wc-FHGjwM2WNPaefr1cw_QLSzK5sf9ty-mj399tWHGUpV8oNNu6PuVcYCV1D7N_hhLH4Z"
        return await admin.messaging().send(payload)
    }
}