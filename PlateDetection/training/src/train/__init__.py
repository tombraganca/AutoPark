from ultralytics import YOLO

def execute():
    model = YOLO('yolov8n.yaml')
    model.train(data='plate.yaml', epochs=1)
    model.val()
    success = model.export(format='onnx')
    return success
