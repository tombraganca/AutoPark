import { prismaClient } from "../../providers/prisma/client";
import { compare } from "bcryptjs";
import { GenerateRefreshTokenProvider } from "../../providers/GenerateRefreshToken/GenereteRefreshTokenProvider";
import { GenerateTokenProvider } from "../../providers/GenerateRefreshToken/GenerateTokenProvider";

interface IRequest {
    email: string;
    password: string;
}

export class AuthUserUseCase {
    async execute({ email, password }: IRequest) {

        const AccountAlreadyExists = await prismaClient.account.findFirst({
            where: {
                email
            }
        });

        if (!AccountAlreadyExists) {
            throw new Error("User or password incorrect");
        }

        const passwordMatch = await compare(password, AccountAlreadyExists.password);

        if (!passwordMatch) {
            throw new Error("User or password incorrect");
        }

        //gerar token do usuário


        const generateTokenProvider = new GenerateTokenProvider();
        const token = await generateTokenProvider.execute(AccountAlreadyExists.id);

        await prismaClient.refreshToken.deleteMany({
            where: {
                accountId: AccountAlreadyExists.id
            }
        });

        const generateRefreshToken = new GenerateRefreshTokenProvider();
        const refreshToken = await generateRefreshToken.execute(AccountAlreadyExists.id);

        return { token, refreshToken };

    }
}