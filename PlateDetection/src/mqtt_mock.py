
import mqtt
import time
from dotenv import load_dotenv


f = open("./test/post-placa-mercosul3.jpg", "rb")
fileContent = f.read()
byteArr = bytearray(fileContent)
top = "autopark/cam_0"
client = mqtt.connect_mqtt()

client.loop_start()
 

result = client.publish(top, byteArr, 2)
status = result[0]
if status == 0:
    print(f"Send img to topic `{top}`")
else:
    print(f"Failed to send message to topic {top}")

time.sleep(5)
client.loop_stop()