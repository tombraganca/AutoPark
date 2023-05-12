import io
from PIL import Image
import cv2
import numpy as np
import matplotlib.pyplot as plt


def byte_image_to_png(message):
    bytes_image = io.BytesIO(message.payload)
    picture = Image.open(bytes_image)
    return picture

def crop_results(results, verbose=False):
    cropped_imgs = []
    if results != None:
        for result in results:
            img = result.orig_img
            gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

            plt.imshow(cv2.cvtColor(gray, cv2.COLOR_BGR2RGB))
            mask = np.zeros(gray.shape, np.uint8)

            if result.boxes != None and len(result.boxes.xyxy) == 1:
                x, y, x1, y2 = result.boxes.xyxy[0]
                chorinho = 4
                
                cropped_image = img[
                    int(y) - chorinho : int(y2) + chorinho, int(x) - chorinho : int(x1) + chorinho
                ]
                new_image = cv2.cvtColor(cropped_image, cv2.COLOR_BGR2GRAY)
                cropped_imgs.append(new_image)
                if verbose:
                    print([int(x) - chorinho, int(x1) + chorinho, int(y) - chorinho, int(y2) + chorinho])
                    plt.imshow(cv2.cvtColor(new_image, cv2.COLOR_BGR2RGB))
                    if len(results) == 2:
                        plt.title(','.join(results))
                    plt.show()
                
        return cropped_imgs
