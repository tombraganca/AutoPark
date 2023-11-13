import os
import requests
import json
from dotenv import load_dotenv

def send_plate(platesPayload):
    print("plates:", platesPayload)
    load_dotenv()
    if len(platesPayload) == 0:
        return
    token = os.getenv("TOKEN")
    api_url = os.getenv("API_URL")

    headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": f"Bearer {token}"
    }

    torreId, plateIds =  platesPayload.split(':')

    payload = {
        "torreId": torreId, 
        "plateIds": plateIds.split(','),
        "accessType": 'in'
    }

    response = requests.post(f"{api_url}/request-access", json=payload, headers=headers)
    if response.status_code == 200:
        print("Placas enviadas com sucesso!")
    else:
        print("Ocorreu um erro ao enviar as Placas.")
