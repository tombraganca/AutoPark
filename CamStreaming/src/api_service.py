import os
import requests


class Api_service:

    def __init__(self):
        self.base_url = os.getenv("AUTO_PARK_API_URL")

    def post(self, endpoint, data):
        url = self.base_url + endpoint
        response = requests.post(url, json=data)
        return response.json()

    def get(self, endpoint):
        url = self.base_url + endpoint
        response = requests.get(url)
        return response.json()

    def put(self, endpoint, data):
        url = self.base_url + endpoint
        response = requests.put(url, json=data)
        return response.json()

    def delete(self, endpoint):
        url = self.base_url + endpoint
        response = requests.delete(url)
        return response.json()
