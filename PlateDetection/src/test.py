import cv2
import numpy as np
import matplotlib.pyplot as plt
from dotenv import dotenv_values
from ocr import validate_ocr
from utils import crop_results, threshold
from request import send_plate
import recognition


values = dotenv_values()

client_id = values["CLIENTID"]

cap = cv2.VideoCapture("./test/Video.mp4", cv2.CAP_FFMPEG)
ret, frame = cap.read()


# Target size (width, height)
target_size = (500, 500)

_ocr_results = ""
while True:
    ret, frame = cap.read()
    if ret == False:
        print("Sem frame")
        break
    else:
        results = recognition.evaluate(frame, False)
        cropped_results = crop_results(results, False)

        for image in cropped_results:
            ocr_results = validate_ocr(image) + validate_ocr(threshold(image))
            # Create a black canvas with the target size
            canvas = np.zeros((target_size[1], target_size[0]), dtype=np.uint8)
            if (
                ocr_results != None
                and len(ocr_results) > 0
                and _ocr_results != ocr_results
            ):
                _ocr_results = ocr_results
                send_plate(client_id + ":" + ",".join(ocr_results))
            label = "Placas: " + ",".join(_ocr_results)
            font = cv2.FONT_HERSHEY_SIMPLEX
            font_scale = 1
            font_thickness = 2
            font_color = (255, 255, 255)  # White color in BGR format

            # Position to place the label (bottom-left corner in this example)
            position = (30, 30)

            cv2.putText(
                canvas, label, position, font, font_scale, font_color, font_thickness
            )
            resized_image = image

            # Calculate the position to paste the resized image with black space
            x_offset = (canvas.shape[1] - resized_image.shape[1]) // 2
            y_offset = (canvas.shape[0] - resized_image.shape[0]) // 2

            # Paste the resized image onto the canvas
            canvas[
                y_offset : y_offset + resized_image.shape[0],
                x_offset : x_offset + resized_image.shape[1],
            ] = resized_image
            cv2.imshow("PLATE", cv2.cvtColor(canvas, cv2.COLOR_BGR2RGB))
            # plt.show()
        cv2.imshow("VIDEO", frame)
    plt.pause(0.20)

    if cv2.waitKey(1) & 0xFF == ord("q"):
        break


cap.release()
cv2.destroyAllWindows()
