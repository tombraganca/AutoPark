import { client } from "../../providers/prisma/client";

interface ICreateParkingDTO {
    name: string;
    location: { long: number, lat: number };
    ownerId: string;
}

export class CreateParkingUseCase {
    async execute(props: ICreateParkingDTO) {
        try {

            if( !props.name || !props.location || !props.ownerId ) throw new Error("Missing required data");

            const businessCreated = await client.parking.create({
                data: {
                    name: props.name,
                    location: props.location,
                    ownerId: props.ownerId
                }
            });

            return businessCreated;
        } catch (error: any) {
            throw new Error(error.message);
        }
    }
}