
import sys
import cv2
import numpy as np
import matplotlib.pyplot as plt
from dotenv import load_dotenv
from ocr import validate_ocr
from utils import crop_results, threshold
import recognition

load_dotenv()

tests = [
    './test/001.jpg',
    './test/002.jpg',
    './test/003.jpg',
    './test/005.jpg',
    './test/006.jpg',
]

index = int(sys.argv[1]) if len(sys.argv) > 1 else 0

results = recognition.evaluate(tests[index])
cropped_results = crop_results(results, False)

for image in cropped_results: 
    ocr_results = validate_ocr(image) + validate_ocr(threshold(image))
    if ocr_results != None and len(ocr_results) > 0:
        plt.title('Placas: ' + ','.join(ocr_results))
    plt.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
    plt.show()
