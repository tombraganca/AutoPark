import cv2
import matplotlib.pyplot as plt
from ultralytics import YOLO

from processing import process_results
from vagas import get_vagas, send_vagas_ocupadas


model = YOLO("yolov8n.pt")
vagas = get_vagas()


video_path = "Video1.mp4"
cap = cv2.VideoCapture(video_path)

while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        break

    results = model(frame)
    frame, vagas_busy = process_results(results, vagas)
    send_vagas_ocupadas(vagas_busy)

    cv2.imshow("Original Frame", frame)
    plt.pause(0.06) #

    if cv2.waitKey(25) & 0xFF == ord("q"):
        cv2.destroyAllWindows()
        break

cap.release()
cv2.destroyAllWindows()
