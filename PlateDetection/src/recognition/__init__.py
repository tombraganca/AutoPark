from ultralytics import YOLO
import matplotlib.pyplot as plt

def evaluate(img, print=False):
    model = YOLO('./best.pt',)
    results = model(img, verbose=print)
    
    if print and len(results) > 0:
        im = results[0].plot()
        plt.imshow(im,cmap='gray')
        plt.draw()
    return results