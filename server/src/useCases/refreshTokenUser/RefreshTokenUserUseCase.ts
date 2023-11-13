import dayjs from 'dayjs';
import { GenerateTokenProvider } from "../../providers/GenerateRefreshToken/GenerateTokenProvider";
import { prismaClient } from "../../providers/prisma/client";
import { GenerateRefreshTokenProvider } from '../../providers/GenerateRefreshToken/GenereteRefreshTokenProvider';


export class RefreshTokenUserCase {
    async execute(refresh_token: string) {
        const refreshToken = await prismaClient.refreshToken.findFirst({
            where: {
                id: refresh_token
            }
        });

        if (!refreshToken) {
            throw new Error("Refresh token invalid");
        }

        const refreshTokenExpired = dayjs().isAfter(dayjs.unix(refreshToken.expiresIn));

        const generateTokenProvider = new GenerateTokenProvider();
        const token = await generateTokenProvider.execute(refreshToken.accountId);

        if (refreshTokenExpired) {
            await prismaClient.refreshToken.deleteMany({
                where: {
                    id: refreshToken.id
                }
            });
            const generateRefreshTokenProvider = new GenerateRefreshTokenProvider();
            const newRefreshToken = await generateRefreshTokenProvider.execute(refreshToken.accountId);

            return { token, refreshToken: newRefreshToken };
        }

        return { token, refreshToken };
    }
}