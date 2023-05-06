import { admin } from "../firebase/config";

export class MessagingProvider {
    async send(payload: any): Promise<string> {
        return await admin.messaging().send(payload)
    }
}