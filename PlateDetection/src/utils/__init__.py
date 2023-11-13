import io
from PIL import Image
import cv2
import matplotlib.pyplot as plt
import numpy as np

def byte_image_to_png(message):
    bytes_image = io.BytesIO(message.payload)
    image = Image.open(bytes_image)
    return image

def crop_results(results, verbose=False):
    cropped_imgs = []
    spacing = 4  # região de corte

    if results:
        for result in results:
            img = result.orig_img
            if result.boxes and len(result.boxes.xyxy) == 1:
                x, y, x1, y2 = result.boxes.xyxy[0]

                cropped_image = img[
                    int(y) - spacing : int(y2) + spacing,
                    int(x) - spacing : int(x1) + spacing,
                ]
                if cropped_image is not None and cropped_image.size > 0 and cropped_image.ndim == 3:                    
                    new_image = cv2.cvtColor(cropped_image, cv2.COLOR_BGR2GRAY)
                    cropped_imgs.append(new_image)
                    if verbose:
                        show_image_with_title(new_image, results)

    return cropped_imgs

def threshold(image):
    img = cv2.GaussianBlur(image.copy(), (3, 3), 0)
    _, img = cv2.threshold(img, 125, 255, cv2.THRESH_BINARY)
    return img

def show_image_with_title(image, results):
    plt.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
    if len(results) == 2:
        plt.title(",".join(results))
    plt.show()

def load_video(video_path):
    cap = cv2.VideoCapture(video_path, cv2.CAP_FFMPEG)
    ret, frame = cap.read()
    return cap, frame

def create_canvas(target_size):
    return np.zeros((target_size[1], target_size[0]), dtype=np.uint8)

def display_plate(canvas, label, position, resized_image):
    font = cv2.FONT_HERSHEY_SIMPLEX
    font_scale = 1
    font_thickness = 2
    font_color = (255, 255, 255)  # White color in BGR format

    cv2.putText(canvas, label, position, font, font_scale, font_color, font_thickness)

    # Calculate the position to paste the resized image with black space
    x_offset = (canvas.shape[1] - resized_image.shape[1]) // 2
    y_offset = (canvas.shape[0] - resized_image.shape[0]) // 2

    # Paste the resized image onto the canvas
    canvas[
        y_offset : y_offset + resized_image.shape[0],
        x_offset : x_offset + resized_image.shape[1],
    ] = resized_image

    cv2.imshow("PLATE", cv2.cvtColor(canvas, cv2.COLOR_BGR2RGB))