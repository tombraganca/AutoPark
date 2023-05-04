import * as mqtt from "mqtt"

const clientMQTT = mqtt.connect('mqtt://localhost:1883', { clientId: 'mqttjs01', username: 'mqtt_user', password: 'mqtt_pass' });

clientMQTT.on('connect', function () {
    clientMQTT.subscribe('presence', function (err) {
        if (!err) {
            clientMQTT.publish('presence', 'Hello mqtt')
        }
    })
});

clientMQTT.on('message', function (topic, message) {
    // message is Buffer
    console.log(message.toString())
    clientMQTT.end()
})
