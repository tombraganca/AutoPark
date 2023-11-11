import { Request, Response } from 'express';
import { CreateParkingUseCase } from './CreateParkingUseCase';

export class CreateParkingController {
    async handle(request: Request, response: Response) {
        try {
            const { name, location } = request.body;
            const ownerId = request.body.userid;

            const createBusinessUseCase = new CreateParkingUseCase();
            const business = await createBusinessUseCase.execute({ name, location, ownerId });

            return response.status(201).json({ message: 'Business created successfully', status: 'success', business });

        } catch (error: any) {
            return response.status(400).json({ message: error.message, status: 'error' });
        }
    }
}