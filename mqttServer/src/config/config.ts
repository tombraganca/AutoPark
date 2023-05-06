import * as dotenv from 'dotenv';
dotenv.config();

export const config = {
    brokerUrl: process.env.BROKER_URL || 'mqtt://localhost:1883',
};