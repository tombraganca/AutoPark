import mqtt from 'mqtt';
import { ConnectionMoqtt } from './Connection';
import { config } from '../../config/config';


const clientId = 'mqttjs_' + Math.random().toString(16).substr(2, 8);
const client = mqtt.connect(config.mqttUrl, { clientId, reconnectPeriod: 1 });

const connectMqtt = new ConnectionMoqtt(client);

client.on("connect", connectMqtt.connect.bind(connectMqtt));
client.on('message', connectMqtt.receivedMessage.bind(connectMqtt));
client.on("error", connectMqtt.handleError.bind(connectMqtt));
client.on("close", connectMqtt.handleClose.bind(connectMqtt));
client.on("reconnect", connectMqtt.handleReconnect.bind(connectMqtt));
client.on("offline", connectMqtt.handleOffline.bind(connectMqtt));

export { client, connectMqtt };




