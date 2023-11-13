from PIL import Image, ImageDraw
import numpy as np
import cv2
from dotenv import dotenv_values
from utils import centralize, check_vaga_status, resize_image


values = dotenv_values()
dist_treshold = float(values['dist_treshold'])
verbose = int(values['verbose'])

def process_results(results, vagas):
    vagas_busy = []
    for result in results:
        source_img = Image.fromarray(result.orig_img.copy())
        draw = ImageDraw.Draw(source_img)

        for box in result.boxes.xyxy:
            x0, y0, x1, y1 = box
            i, j = centralize(x0, x1), centralize(y0, y1)
            is_busy = False

            for vaga in vagas:
                is_vaga_busy, dist = check_vaga_status(vaga, i, j, dist_treshold)
                if is_vaga_busy:
                    draw.text((centralize(box[0], box[2]), box[3] + 16), f"d: {str(int(dist))}")
                    vaga["situation"] = "busy"
                    vagas_busy.append(vaga["id"])
                    is_busy = True

            draw.rectangle( [(box[0], box[1]), (box[2], box[3])], width=3, outline=("red" if is_busy else "green") )
            draw.rectangle([(i, j), (i + 3, j + 3)], fill="green")

            if is_busy:
                draw.text( (box[0], box[3] + 3), f"Ocupado", fill = "red", outline = "white" )

        for vaga in vagas:
            x, y = vaga['center']['x'], vaga['center']['y']
            draw.text((x, y), f"{vaga['id']}", fill="yellow")
            if vaga['situation'] == 'busy' and verbose:
                print(f'A vaga {vaga["title"]} está ocupada.')

        return resize_image(source_img, 800, 600), vagas_busy



def load_video_sources(urls):
    return [cv2.VideoCapture(source) for source in urls]

def check_video_capture(caps):
    if any(not cap.isOpened() for cap in caps):
        print("Error opening one or more video sources.")
        exit()

def read_frames(caps):
    return [cap.read()[1] if cap.read()[0] else np.zeros((1920, 1080, 3), dtype=np.uint8) for cap in caps]

def update_frames(frames, model, vagas):
    pro_frames = [
        process_results(
            model(frame, verbose=False),
            [vaga for vaga in vagas if vaga["section"] == index + 1],
        )
        for index, frame in enumerate(frames)
    ]
    return [result[0] for result in pro_frames], [item for sublist in [result[1] for result in pro_frames] for item in sublist]

def resize_frames(frames, canvas_width, canvas_height, caps):
    n_width, n_height = canvas_width, canvas_height
    resized_frames = [
        cv2.resize(frame, (n_width // int((len(caps) // 2)), n_height // 2))
        for frame in frames
    ]

    mid_index = len(caps) // 2
    cut_at = mid_index + (0 if len(caps) == 2 else 1)
    top_frames, bottom_frames = resized_frames[:cut_at], resized_frames[cut_at:]

    if len(top_frames) > len(bottom_frames) and len(caps) > 1:
        black_image = np.zeros((n_width, n_height, 3), dtype=np.uint8)
        bottom_frames.append(
            cv2.resize(black_image, (n_width // int((len(caps) // 2)), n_height // 2))
        )

    top_canvas = np.hstack(
        [
            cv2.resize(frame, (n_width // len(top_frames), n_height // 2))
            for frame in top_frames
        ]
    ) if top_frames else np.zeros((canvas_height // 2, 1, 3), dtype=np.uint8)

    bottom_canvas = np.hstack(
        [
            cv2.resize(frame, (n_width // len(bottom_frames), n_height // 2))
            for frame in bottom_frames
        ]
    ) if bottom_frames else np.zeros((canvas_height // 2, 1, 3), dtype=np.uint8)

    return np.vstack([top_canvas, bottom_canvas])

def display_canvas(canvas):
    cv2.imshow("SmartPark Client", canvas)