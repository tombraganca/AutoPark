import { sign } from "jsonwebtoken";

export class GenerateTokenProvider {
    async execute(accountId: string) {
        const token = sign({}, "fb4e6935-9de5-4d33-b256-e956ad5cf8a1", {
            subject: accountId,
            expiresIn: "1d"
        });

        return token;
    }
}