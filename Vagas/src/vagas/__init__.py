import os
import requests
import json
from dotenv import load_dotenv

def get_vagas():
    with open('vacancies.json') as file:
        return json.load(file)
    load_dotenv()
    token = os.getenv("TOKEN")
    api_url = os.getenv("API_URL")

    headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": f"Bearer {token}"
    }

    response = requests.get(f"{api_url}/vacancies?filter=all&parkingId=TORRE01", headers=headers)
    vagas = response.json()
    return vagas

def send_vagas_ocupadas(vagas_ocupadas):
    print("situacao das vagas:", vagas_ocupadas)
    return
    load_dotenv()
    if len(vagas_ocupadas) == 0:
        return
    token = os.getenv("TOKEN")
    api_url = os.getenv("API_URL")

    headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": f"Bearer {token}"
    }

    payload = {
        "vagas_ocupadas": vagas_ocupadas
    }

    response = requests.post(f"{api_url}/vagas_ocupadas", json=payload, headers=headers)
    if response.status_code == 200:
        print("Vagas ocupadas enviadas com sucesso!")
    else:
        print("Ocorreu um erro ao enviar as vagas ocupadas.")
