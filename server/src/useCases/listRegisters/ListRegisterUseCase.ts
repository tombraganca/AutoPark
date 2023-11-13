import { prismaClient } from "../../providers/prisma/client";

export class ListRegisterUseCase {
    async execute(userId: string) {
        if (!userId) {
            throw new Error("Missing information");
        }

        try {

            const registers = await prismaClient.access.findMany({
                where: {
                    ownerId: userId
                },
                orderBy: {
                    date: 'desc'
                }
            })

            return registers
        } catch (error: any) {
            throw new Error(error.message);
        }
    }
}