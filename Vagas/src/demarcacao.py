import cv2
import os
import sys
from dotenv import dotenv_values
from matplotlib import pyplot as plt
from vagas import create_vacancy


if len(sys.argv) < 3:
    print("Usage: python script.py <SECTION> <CAMERA_INDEX>")
    sys.exit(1)

SECTION = sys.argv[1]
camera_index = int(sys.argv[2])
fit_x, fit_y = 0, 120
os.environ['OPENCV_FFMPEG_CAPTURE_OPTIONS'] = 'rtsp_transport;udp'

values = dotenv_values()
URLs = str(values["CAMERAS"]).split(',')

if camera_index >= len(URLs):
    print("Invalid camera index. Choose an index within the range of available cameras.")
    sys.exit(1)

URL = URLs[camera_index]

print(f'Conectando com a câmera {camera_index}: {URL}')

points = []

def generate_json_text(x, y):
    json_text = (
        '{"title": "Vaga ' + str(x) + '", "description": "Primeira esquerda", '
        '"id": "' + str(x) + '", "type": "normal", "center": {"x": ' + str(x + fit_x) +
        ', "y": ' + str(y + fit_y) + '}, "situation": "free", "section": ' + str(SECTION) + '},'
    )
    return json_text

def click_event(event, x, y, flags, param):
    if event == cv2.EVENT_LBUTTONDOWN:
        create_vacancy(generate_json_text(x, y))
        points.append((x, y))

cap = cv2.VideoCapture(URL, cv2.CAP_FFMPEG)
ret, frame = cap.read()

while True:
    ret, frame = cap.read()
    if ret == False:
        print("Sem frame")
        break
    else:
        if frame.shape[1] > 860:
            frame = cv2.resize(frame, (1980, 860))
        for point in points:
            cv2.circle(frame, point, 8, (255, 255, 255), -1)
        cv2.imshow('VIDEO', frame)
        cv2.setMouseCallback("VIDEO", click_event)
        
    if cv2.waitKey(0) & 0xFF == ord('q'):
        break
    plt.pause(0.06)

cap.release()
cv2.destroyAllWindows()
