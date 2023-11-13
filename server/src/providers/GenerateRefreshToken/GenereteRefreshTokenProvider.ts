import { prismaClient } from "../prisma/client";
import dayjs from "dayjs";

export class GenerateRefreshTokenProvider {
    async execute(userId: string) {
        const expiresIn = dayjs().add(15, "second").unix();

        const generateRefreshToken = await prismaClient.refreshToken.create({
            data: {
                accountId: userId,
                expiresIn
            },
        });

        return generateRefreshToken;
    }
}