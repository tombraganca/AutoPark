import * as dotenv from 'dotenv';
dotenv.config();

export const config = {
    port: process.env.PORT,
    brokerUrl: process.env.BROKER_URL,
    jwtSecret: process.env.JWT_SECRET || 'secret'
}