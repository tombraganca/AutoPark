import cv2
import matplotlib.pyplot as plt
from dotenv import dotenv_values
from ocr import validate_ocr
from utils import create_canvas, crop_results, display_plate, load_video, threshold
from request import send_plate
import recognition

def main():
    values = dotenv_values()
    client_id = values["CLIENTID"]

    cap, frame = load_video("./test/Video.mp4")

    target_size = (500, 500) # Target size (width, height)

    _ocr_results = ""
    while True:
        ret, frame = cap.read()
        if not ret:
            print("Sem frame")
            break

        results = recognition.evaluate(frame, False)
        cropped_results = crop_results(results, False)

        for image in cropped_results:
            ocr_results = validate_ocr(image) + validate_ocr(threshold(image))

            canvas = create_canvas(target_size)

            if ocr_results and len(ocr_results) > 0 and _ocr_results != ocr_results:
                _ocr_results = ocr_results
                send_plate(client_id + ":" + ",".join(ocr_results))

            label = "Placas: " + ",".join(_ocr_results)
            position = (30, 30)

            display_plate(canvas, label, position, image)

        cv2.imshow("VIDEO", frame)
        plt.pause(0.20)

        if cv2.waitKey(1) & 0xFF == ord("q"):
            break

    cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    main()