import * as dotenv from 'dotenv';
dotenv.config();

export const config = {
    port: process.env.PORT,
    brokerUrl: process.env.BROKER_URL,
    jwtSecret: process.env.JWT_SECRET || 'secret',
    mqttTopic: process.env.MQTT_TOPIC || 'test/autopark',
    mqttUrl: process.env.MQTT_URL || 'mqtt://test.mosquitto.org'
}