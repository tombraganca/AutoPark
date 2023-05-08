import re
import requests
import os


class Request_access:

    def __init__(self, plate, accessType):
        # REGEX to validate plate
        regex_plate = re.compile(r'^[A-Z]{3}[0-9][0-9A-Z][0-9]{2}$')

        if not regex_plate.match(plate):
            raise ValueError('Invalid plate')

        if accessType not in ['in', 'out']:
            raise ValueError('Invalid access type')

        self.plate = plate
        self.accessType = accessType

    def do_request(self):
        url = os.getenv("AUTO_PARK_API_URL") + '/request-access'
        print(url)
        dados = {'plate': self.plate, 'accessType': self.accessType}
        response = requests.post(url, json=dados)
        return response.json()
