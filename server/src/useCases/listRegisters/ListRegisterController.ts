import { Request, Response } from 'express';
import { ListRegisterUseCase } from './ListRegisterUseCase';

export default class ListRegisterController {
    async handle(request: Request, response: Response): Promise<Response> {

        const { userid } = request.body;
        
        const listRegisterUseCase = new ListRegisterUseCase();
        const registers = await listRegisterUseCase.execute(userid);

        return response.json(registers);
    }
}