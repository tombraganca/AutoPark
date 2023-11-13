import cv2
import os
import matplotlib.pyplot as plt
from ultralytics import YOLO
import numpy as np
from dotenv import dotenv_values

from processing import process_results
from vagas import get_vagas, send_vagas_ocupadas
from utils import atualizar_situacao_vagas


values = dotenv_values()
urls = str(values["CAMERAS"])

urlsList = list(urls.split(","))

model = YOLO("yolov8n.pt")
vagas = get_vagas()

os.environ["OPENCV_FFMPEG_CAPTURE_OPTIONS"] = "rtsp_transport;udp"

caps = [cv2.VideoCapture(source) for source in urlsList]

# Check if the video capture instances are opened correctly
if any(not cap.isOpened() for cap in caps):
    print("Error opening one or more video sources.")
    exit()

canvas_width, canvas_height = 1960, 870
intervalo_tempo = 200
tempo_atual = 0

while True:
    # Read frames from each video source
    black_image = np.zeros((1920, 1080, 3), dtype=np.uint8)
    frames = [cap.read()[1] if cap.read()[0] else black_image for cap in caps]
    if tempo_atual == intervalo_tempo or tempo_atual == 0:
        print('update frame')
        tempo_atual = 0
        pro_frames = [
            process_results(
                model(frame, verbose=False),
                [vaga for vaga in vagas if vaga["section"] == index + 1],
            )
            for index, frame in enumerate(frames)
        ]
        frames = [result[0] for result in pro_frames]
        vagas_busy = [item for sublist in [result[1] for result in pro_frames] for item in sublist]
        situacao_vagas = atualizar_situacao_vagas(vagas, vagas_busy)
        send_vagas_ocupadas(situacao_vagas)

        # Check if the reading of frames was successful
        if any(frame is None for frame in frames):
            print("Error reading frames from one or more video sources.")
            break
        if len(frames) > 1:
            n_width, n_height = canvas_width, canvas_height
            # Resize frames while maintaining aspect ratio and fitting within canvas width and height
            resized_frames = [
                cv2.resize(frame, (n_width // int((len(caps) // 2)), n_height // 2))
                for frame in frames
            ]

            # Arrange frames with an index greater than len(caps) / 2 at the bottom
            mid_index = len(caps) // 2
            cut_at = mid_index + (0 if len(caps) == 2 else 1)
            top_frames = resized_frames[:cut_at]
            bottom_frames = resized_frames[cut_at:]
            if len(top_frames) > len(bottom_frames) and len(caps) > 1:
                black_image = np.zeros((n_width, n_height, 3), dtype=np.uint8)
                bottom_frames.append(
                    cv2.resize(
                        black_image, (n_width // int((len(caps) // 2)), n_height // 2)
                    )
                )

            # Resize each frame individually based on the available space
            top_canvas = (
                np.hstack(
                    [
                        cv2.resize(frame, (n_width // len(top_frames), n_height // 2))
                        for frame in top_frames
                    ]
                )
                if top_frames
                else np.zeros((canvas_height // 2, 1, 3), dtype=np.uint8)
            )
            bottom_canvas = (
                np.hstack(
                    [
                        cv2.resize(frame, (n_width // len(bottom_frames), n_height // 2))
                        for frame in bottom_frames
                    ]
                )
                if bottom_frames
                else np.zeros((canvas_height // 2, 1, 3), dtype=np.uint8)
            )

            # Concatenate top and bottom sections vertically to create the canvas
            canvas = np.vstack([top_canvas, bottom_canvas])

            # Display the canvas
            cv2.imshow("SmartPark Client", canvas)
        else:
            cv2.imshow("SmartPark Client", frames[0])
    # Exit the loop when the 'q' key is pressed
    if cv2.waitKey(1) & 0xFF == ord("q"):
        break
    tempo_atual+=1
    plt.pause(0.06) 
    #time.sleep(0.06)

for cap in caps:
    cap.release()
cv2.destroyAllWindows()
