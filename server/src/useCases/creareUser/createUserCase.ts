import { client } from "../../providers/prisma/client";
import { hash } from "bcryptjs"

interface IUserRequest {
    email: string;
    password: string;
    name: string;
}

export class CreateUserUserCase {

    async execute({ email, password, name }: IUserRequest) {
        if (!email || !password || !name) {
            throw new Error("Missing information");
        }

        const userAlreadyExists = await client.account.findFirst({
            where: {
                email
            }
        });

        if (userAlreadyExists) {
            throw new Error("User already exists");
        }

        const passwordHash = await hash(password, 8);

        const user = await client.account.create({
            data: {
                email,
                password: passwordHash,
                name
            }
        });

        return { name: user.name, email: user.email, id: user.id };
    }
}