
from dotenv import load_dotenv
from ocr import validate_ocr
from utils import crop_results
import recognition
import mqtt
load_dotenv()

mqtt.run()