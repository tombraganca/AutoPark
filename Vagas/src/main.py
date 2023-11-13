import cv2
import os
import matplotlib.pyplot as plt
from ultralytics import YOLO
from dotenv import dotenv_values

from vagas import get_vagas, send_vagas_ocupadas
from processing import check_video_capture, display_canvas, load_video_sources, read_frames, resize_frames, update_frames 
from utils import atualizar_situacao_vagas


def main():
    values = dotenv_values()
    urls = str(values["CAMERAS"])
    urls_list = list(urls.split(","))
    
    model = YOLO("yolov8n.pt")
    vagas = get_vagas()

    os.environ["OPENCV_FFMPEG_CAPTURE_OPTIONS"] = "rtsp_transport;udp"

    caps = load_video_sources(urls_list)
    check_video_capture(caps)

    canvas_width, canvas_height = 1960, 870
    intervalo_tempo = 100
    tempo_atual = 0

    while True:
        frames = read_frames(caps)

        if tempo_atual == intervalo_tempo or tempo_atual == 0:
            print('update frame')
            tempo_atual = 0

            frames, vagas_busy = update_frames(frames, model, vagas)
            situacao_vagas = atualizar_situacao_vagas(vagas, vagas_busy)
            send_vagas_ocupadas(situacao_vagas)

            if any(frame is None for frame in frames):
                print("Error reading frames from one or more video sources.")
                break

            if len(frames) > 1:
                canvas = resize_frames(frames, canvas_width, canvas_height, caps)
                display_canvas(canvas)
            else:
                cv2.imshow("SmartPark Client", frames[0])

        if cv2.waitKey(1) & 0xFF == ord("q"):
            break

        tempo_atual += 1
        plt.pause(0.06)

    for cap in caps:
        cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    main()
