import io
from PIL import Image
import cv2
import matplotlib.pyplot as plt


def byte_image_to_png(message):
    bytes_image = io.BytesIO(message.payload)
    image = Image.open(bytes_image)
    return image


def crop_results(results, verbose=False):
    cropped_imgs = []
    if results != None:
        for result in results:
            img = result.orig_img
            if result.boxes != None and len(result.boxes.xyxy) == 1:
                x, y, x1, y2 = result.boxes.xyxy[0]
                chorinho = 4  #  região de corte

                cropped_image = img[
                    int(y) - chorinho : int(y2) + chorinho,
                    int(x) - chorinho : int(x1) + chorinho,
                ]
                new_image = cv2.cvtColor(cropped_image, cv2.COLOR_BGR2GRAY)
                cropped_imgs.append(new_image)
                if verbose:
                    print(
                        [
                            int(x) - chorinho,
                            int(x1) + chorinho,
                            int(y) - chorinho,
                            int(y2) + chorinho,
                        ]
                    )
                    plt.imshow(cv2.cvtColor(new_image, cv2.COLOR_BGR2RGB))
                    if len(results) == 2:
                        plt.title(",".join(results))
                    plt.show()

        return cropped_imgs

def threshold(image):
    img = cv2.GaussianBlur(image.copy(), (3, 3), 0)
    _, img = cv2.threshold(img, 125, 255, cv2.THRESH_BINARY)
    return img
