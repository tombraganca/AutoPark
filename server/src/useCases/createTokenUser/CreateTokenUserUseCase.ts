import { client } from "../../providers/prisma/client";


interface IPayloadCreateTokenUser {
    accountId: string;
    token: string;
}
export class CreateTokenUserUseCase {
    async execute({ accountId, token }: IPayloadCreateTokenUser) {

        try {

            const user = client.account.findFirst({
                where: {
                    id: accountId
                }
            });

            if (!user) {
                return { status: 'Error', message: 'User not found' }
            }

            await client.accountToken.create({
                data: {
                    accountId: accountId,
                    token: token,
                    device: 'mobile'
                }
            });

            return { status: 'Success', message: 'Token created' }

        } catch (error: any) {
            return { status: 'Error', message: error.message }
        }

    }
}