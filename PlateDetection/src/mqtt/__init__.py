
from dotenv import dotenv_values
from paho.mqtt import client as mqtt_client
import recognition
from utils import byte_image_to_png, crop_results, threshold
from ocr import validate_ocr
from datetime import datetime

values = dotenv_values()

broker = values['broker']
port = int(values['port'])
topic = values['topic']
topic_plate = values['topic_plate']
client_id = values['client_id'] + datetime.now().strftime("%Y%m%d%H%M%S")
username = values['username']
password = values['password']

def connect_mqtt() -> mqtt_client:
    def on_connect(client, userdata, flags, rc):
        if rc == 0:
            print("Connected to MQTT Broker!")
        else:
            print("Failed to connect, return code %d\n", rc)

    client = mqtt_client.Client(client_id)
    if username != '' and username != '' :
        client.username_pw_set(username, password)

    client.on_connect = on_connect
    client.connect(broker, port)
    return client

def publish(client, msg, top):
    result = client.publish(top, msg)
    status = result[0]
    if status == 0:
        print(f"Send `{msg}` to topic `{top}`")
    else:
        print(f"Failed to send message to topic {top}")


def subscribe(client: mqtt_client):
    def on_message(client, userdata, msg):
        print(f"Received from `{msg.topic}` topic")
        print(f"Received `{msg.payload[:2]}` from `{msg.topic}` topic")
        img = byte_image_to_png(msg)
        detection = recognition.evaluate(img, True)
        cropped_results = crop_results(detection, False)
        for image in cropped_results: 
            ocr_results = validate_ocr(image) + validate_ocr(threshold(image))
            if len(ocr_results) > 0:
                publish(client, ','.join(ocr_results), topic_plate)

    client.subscribe(topic)
    client.on_message = on_message


def run():
    client = connect_mqtt()
    subscribe(client)
    client.loop_forever()

