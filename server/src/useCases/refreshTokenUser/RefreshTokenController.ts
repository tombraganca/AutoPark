import { Response, Request } from "express";
import { RefreshTokenUserCase } from "./RefreshTokenUserUseCase";

export class RefreshTokenUserController {
    async handle(request: Request, response: Response) {
        const { refreshToken } = request.body;

        const refreshTokenUserCase = new RefreshTokenUserCase();
        const token = await refreshTokenUserCase.execute(refreshToken);

        return response.json(token);
    }
}