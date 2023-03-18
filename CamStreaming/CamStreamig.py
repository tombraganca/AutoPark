import cv2
import os
import flask

USERNAME = 'admin'
PASSWORD = 'teste123'
IP = '192.168.18.152'
PORT = '554'

os.environ['OPENCV_FFMPEG_CAPTURE_OPTIONS'] = 'rtsp_transport;udp'

URL = 'rtsp://{}:{}@{}:{}/onvif1'.format(USERNAME, PASSWORD, IP, PORT)

print('Coonectando com: ' + URL)

cap = cv2.VideoCapture(URL, cv2.CAP_FFMPEG)
ret, frame = cap.read()

while True:
    ret, frame = cap.read()
    if ret == False:
        print("Sem frame")
        break
    else:
        cv2.imshow('VIDEO', frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
