import os
import requests
import json
from dotenv import load_dotenv

def get_vagas():
    print("backend action => pega lista de vagas")
    with open('vacancies.json') as file:
        return json.load(file)
    load_dotenv()
    token = os.getenv("TOKEN")
    api_url = os.getenv("API_URL")
    parkingId= os.getenv("ID")

    headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": f"Bearer {token}"
    }

    response = requests.get(f"{api_url}/vacancies?filter=all&parkingId={parkingId}", headers=headers)
    vagas = response.json()
    return vagas

def send_vagas_ocupadas(vagas_ocupadas):
    print("backend action => atualiza situacao das vagas:", vagas_ocupadas)
    return
    load_dotenv()
    if len(vagas_ocupadas) == 0:
        return
    token = os.getenv("TOKEN")
    api_url = os.getenv("API_URL")
    parkingId= os.getenv("ID")

    headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": f"Bearer {token}"
    }

    payload = {
        "vagas_ocupadas": vagas_ocupadas
    }

    response = requests.post(f"{api_url}/vagas_ocupadas&parkingId={parkingId}", json=payload, headers=headers)
    if response.status_code == 200:
        print("Vagas ocupadas enviadas com sucesso!")
    else:
        print("Ocorreu um erro ao enviar as vagas ocupadas.")


def create_vacancy(json_text):
    print("backend action => cria vaga:", json_text)
    return
    load_dotenv()

    token = os.getenv("TOKEN")
    api_url = os.getenv("API_URL")
    parkingId= os.getenv("ID")

    headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": f"Bearer {token}"
    }

    try:
        response = requests.post(f"{api_url}/updateVacancy&parkingId={parkingId}", headers=headers, data=json_text)
        response.raise_for_status()

        if response.status_code == 200:
            print("Vacancy created successfully!")
        else:
            print(f"Failed to create vacancy. Status code: {response.status_code}")

    except requests.exceptions.RequestException as e:
        print(f"Error creating vacancy: {e}")