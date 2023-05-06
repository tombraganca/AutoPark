import { MqttClient, IConnackPacket } from "mqtt"

export class ConnectionMoqtt {

    private client: MqttClient;
    private topicName = 'test/autopark'

    constructor(client: MqttClient) {
        this.client = client;
    }

    public connect(connack: IConnackPacket) {
        console.log("Connected to broker", connack)
        this.client.subscribe(this.topicName, { qos: 1 }, (err, granted) => {
            if (err) {
                console.log("Error subscribing to topic", err)
            }
            console.log("Subscribed to topic", granted)
        })
    }

    public receivedMessage(topic: string, message: Buffer, packet: any) {
        console.log("Received '" + message + "' on '" + topic + "'")
    }

    public handleError(error: Error) {
        console.log("Error occured:", error)
    }

    public handleClose() {
        console.log("Client closed")
    }

    public handleReconnect() {
        console.log("Client trying a reconnection")
    }

    public handleOffline() {
        console.log("Client is offline")
    }

}