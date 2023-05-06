import mqtt from 'mqtt';
import { config } from './config/config';
import { ConnectionMoqtt } from './Connection';


console.log(config.brokerUrl);
const clientId = 'mqttjs_' + Math.random().toString(16).substr(2, 8);
const client = mqtt.connect('mqtt://test.mosquitto.org', { clientId, reconnectPeriod: 1 });

const connectMqtt = new ConnectionMoqtt(client);

client.on("connect", connectMqtt.connect.bind(connectMqtt));
client.on('message', connectMqtt.receivedMessage.bind(connectMqtt));
client.on("error", connectMqtt.handleError.bind(connectMqtt));
client.on("close", connectMqtt.handleClose.bind(connectMqtt));
client.on("reconnect", connectMqtt.handleReconnect.bind(connectMqtt));
client.on("offline", connectMqtt.handleOffline.bind(connectMqtt))  
