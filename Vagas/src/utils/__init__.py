import math
import cv2
import numpy as np

def centralize(v1, v2):
    return v1 + (v2 - v1) / 2

def check_vaga_status(vaga, x, y, dist_treshold):
    img_center = vaga["center"]
    vaga_x, vaga_y = img_center["x"], img_center["y"]
    dist = math.sqrt((x - vaga_x) ** 2 + (y - vaga_y) ** 2)

    if dist < dist_treshold:
        return True, dist
    return False, dist

def resize_image(image, width, height):
    return cv2.resize(np.array(image), (width, height))

def atualizar_situacao_vagas(lista_vagas, ids_ocupados):
    vagas_atualizadas = []

    for vaga in lista_vagas:
        vaga_id = vaga["id"]
        if vaga_id in ids_ocupados:
            vaga["situation"] = "busy"
        else:
            vaga["situation"] = "free"
        
        vagas_atualizadas.append({"id": vaga_id, "situation": vaga["situation"]})

    return vagas_atualizadas
