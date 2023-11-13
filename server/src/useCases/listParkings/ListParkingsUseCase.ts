import { prismaClient } from "../../providers/prisma/client";

export class ListParkingsUseCase {
    async execute(filter: string | undefined) {

        try {
            // Busca todos os estacionamentos no banco de dados por name se o filtro for undefined
            // not sentsitive case
            const parkings = await prismaClient.parking.findMany({
                where: {
                    name: {
                        contains: filter,
                        mode: "insensitive"
                    }
                }
            });

            return parkings
        } catch (error: any) {
            throw new Error(error.message);
        }
    }
}