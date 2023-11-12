import time
import cv2
import os


USERNAME = 'admin'
PASSWORD = 'Asdfghjkl01'
IP = '192.168.0.103'
PORT = '554'

SECTION = 2
fit_x, fit_y = 0, 0
os.environ['OPENCV_FFMPEG_CAPTURE_OPTIONS'] = 'rtsp_transport;udp'

URL = 'rtsp://{}:{}@{}:{}/onvif1'.format(USERNAME, PASSWORD, IP, PORT)

print('Coonectando com: ' + URL)

def click_event(event, x, y, flags, param):
    if event == cv2.EVENT_LBUTTONDOWN:
        text = '{"title": "Vaga '+ str(x) + '", "description": "Primeira esquerda", "id": "' +str(x) + '", "type": "normal", '
        text +='"center": {"x":'+ str(x+fit_x) +  ', "y": ' + str(y+fit_y) + '} '
        text += ', "situation": "free", "section": '+str(SECTION) + '},'
        print(text)



#cap = cv2.VideoCapture(URL, cv2.CAP_FFMPEG)
cap = cv2.VideoCapture('Video.mp4', cv2.CAP_FFMPEG)
ret, frame = cap.read()

while True:
    ret, frame = cap.read()
    if ret == False:
        print("Sem frame")
        break
    else:
        # Convert the frame to JPEG format
        _, jpeg_data = cv2.imencode('.jpg', frame)

        # Get the byte size of the JPEG data
        byte_size = len(jpeg_data.tobytes())
        #print(frame.shape)
        # Print the byte size
        # print(f"Image byte size: {byte_size} bytes")
        #frame = cv2.resize(frame, (1980, 860))
        cv2.imshow('VIDEO', frame)
        # Set the callback function for mouse events
        cv2.setMouseCallback("VIDEO", click_event)
        
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
    time.sleep(10)

cap.release()
#cv2.destroyAllWindows()
