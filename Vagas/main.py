import cv2
import math
import numpy as np
from PIL import Image, ImageDraw
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from ultralytics import YOLO
import time

def disp(img):
    plt.imshow(img, cmap='gray')
    plt.show()

def centralize(v1, v2):
    return v1 + (v2 - v1) / 2

def check_vaga_status(vaga, x, y, dist_treshold):
    img_center = vaga["center"]
    vaga_x, vaga_y = img_center["x"], img_center["y"]
    dist = math.sqrt((x - vaga_x) ** 2 + (y - vaga_y) ** 2)

    if dist < dist_treshold:
        return True, dist
    return False, dist

def process_results(results, vagas):
    for result in results:
        source_img = Image.fromarray(result.orig_img)
        draw = ImageDraw.Draw(source_img)
        w, h = source_img.size

        for vaga in vagas:
            is_busy, dist = check_vaga_status(vaga, w, h, dist_treshold)
            x, y = vaga["center"]["x"], vaga["center"]["y"]
            draw.text((x, y), f"{vaga['title']}", fill="yellow")

        for box in results[0].boxes.xyxy:
            x0, y0, x1, y1 = box
            i, j = centralize(x0, x1), centralize(y0, y1)
            is_busy = False

            for vaga in vagas:
                is_vaga_busy, dist = check_vaga_status(vaga, i, j, dist_treshold)
                if is_vaga_busy:
                    draw.text((i - 80, j + 120), f"dist: {str(int(dist))}")
                    vaga['situation'] = "busy"
                    is_busy = True

            draw.rectangle(
                [(box[0], box[1]), (box[2], box[3])],
                width=3,
                outline=("red" if is_busy else "green"),
            )
            draw.rectangle([(i, j), (i + 5, j + 5)], fill="green")

            if is_busy:
                draw.text(
                    (centralize(box[0], box[2]), box[3]+3),
                    f"Ocupado",
                    fill="red",
                    outline="white"
                )

        for vaga in vagas:
            if vaga["situation"] == 'busy':
                print(f'A vaga {vaga["title"]} está ocupada.')

        return source_img

# Configurações
dist_treshold = 25

# Carregar modelo YOLOv8 e definir vagas de estacionamento
model = YOLO("yolov8n.pt")
vagas = [
    {"title": "V #", "center": {"x": 5, "y": 170}, "situation": "free"} 
]
for i in range(1, 11):
    vagas.append({"title": "V #", "center": {"x": i* 60 , "y": 170}, "situation": "free"} )
# Processar vídeo
video_path = "Video1.mp4"  # Substitua pelo cam
cap = cv2.VideoCapture(video_path)

while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        break

    # Detectar carros no frame
    results = model(frame)

    # Processar resultados e exibir imagem com detecções e status das vagas
    img = process_results(results, vagas)
    # Define the desired width and height for the resized image
    desired_width = 800
    desired_height = 600

    # Resize the image
    resized_image = cv2.resize(np.array(img), (desired_width, desired_height))
    # Exibir frame original com detecções
    cv2.imshow("Original Frame", resized_image)
    plt.pause(0.03)
    if cv2.waitKey(25) & 0xFF == ord("q"):
        cv2.destroyAllWindows()
        break

cap.release()
cv2.destroyAllWindows()

