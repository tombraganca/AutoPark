import re
import api_service


class Request_access:

    service = api_service.Api_service()

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
        print('Requesting access for plate: ' + self.plate)
        
        return self.service.post('/request-access', {
            'plate': self.plate,
            'accessType': self.accessType
        })
