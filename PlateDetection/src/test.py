
import sys
import cv2
import numpy as np
import matplotlib.pyplot as plt
from dotenv import load_dotenv
from ocr import validate_ocr
from utils import crop_results
import recognition

load_dotenv()

tests = [
    './test/post-placa-mercosul3.jpg',
    './test/car_blue.jpg',
    './test/novo-modelo-de-placas-2.jpg',
    './test/Detran_Minas-Gerais.jpg',
]

index = int(sys.argv[1]) if len(sys.argv) > 1 else 0

results = recognition.evaluate(tests[index])

cropped_results = crop_results(results, False)

for img in cropped_results: 
    ocr_results = validate_ocr(img)
    plt.imshow(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
    if ocr_results != None and len(ocr_results) == 2:
        plt.title(','.join(ocr_results))
    plt.show()
