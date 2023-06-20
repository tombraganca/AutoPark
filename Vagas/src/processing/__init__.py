from PIL import Image, ImageDraw
from dotenv import dotenv_values
from utils import centralize, check_vaga_status, resize_image

values = dotenv_values()
dist_treshold = float(values['dist_treshold'])
verbose = int(values['verbose'])

def process_results(results, vagas):
    for result in results:
        vagas_busy = []
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
