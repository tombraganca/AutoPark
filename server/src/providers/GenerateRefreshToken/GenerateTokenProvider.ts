import { sign } from "jsonwebtoken";
import { config } from "../../config/config"; 

export class GenerateTokenProvider {
    async execute(accountId: string) {
        const token = sign({}, config.jwtSecret, {
            subject: accountId,
            expiresIn: "1d"
        });

        return token;
    }
}