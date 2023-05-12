import api_service


class Update_aacancy:

    service = api_service.Api_service()

    def __init__(self, id, title='', description='', type='', situation=''):
        self.id = id
        self.title = title
        self.description = description
        self.type = type
        self.situation = situation

    def update(self):
        try:
            self.service.put('/vacancies/' + self.id, {
                'title': self.title,
                'description': self.description,
                'type': self.type,
                'situation': self.situation
            })

            return True
        except:
            return False
