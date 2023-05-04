import { Response, Request } from 'express';
import { ListCarUseCase } from './ListCarUseCase';
export class ListCarController {
    async handle(request: Request, response: Response) {
        const { userid } = request.body;

        console.log(request.body)

        const listCarUseCase = new ListCarUseCase();

        const cars = await listCarUseCase.execute(userid);

        return response.json(cars);

    }
}