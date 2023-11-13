import { Request, Response } from "express";
import { CreateAccessRegisterUseCase } from "./CreateAccessRegisterUseCase";

export class CreateAccessRegisterController {
    async handle(request: Request, response: Response) {
        const { accessType, plate, userid, parkingId } = request.body;

        if (!accessType || !plate) {
            return response.status(400).json({ message: 'Invalid data' });
        }

        try {

            const createAccessRegisterUseCase = new CreateAccessRegisterUseCase();
            const accessRegister = await createAccessRegisterUseCase.execute({
                accessType,
                plate,
                parkingId,
                date: new Date(),
                ownerId: userid
            });
            return response.status(201).json(accessRegister);
        } catch (error: any) {
            return response.status(400).json({ message: error.message, status: 'error' });
        }
    }
}