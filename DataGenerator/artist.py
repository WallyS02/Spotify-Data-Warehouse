import os
import pandas as pd
from faker import Faker
from constants import ARTISTS_NUMBER

path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Data')

faker = Faker()


def generate_artists():
    print('Artists generation start')
    df = pd.DataFrame(columns=['NAME', 'SURNAME', 'BIRTH_DATE', 'EMAIL', 'PHONE_NUMBER', 'PSEUDONYM'])
    for _ in range(ARTISTS_NUMBER):
        entity = pd.DataFrame({
            "NAME": [faker.first_name()],
            "SURNAME": [faker.last_name()],
            "BIRTH_DATE": [faker.date_of_birth(minimum_age=18).strftime('%Y-%m-%d')],
            "PHONE_NUMBER": [faker.phone_number()],
            "EMAIL": [faker.ascii_email()],
            "PSEUDONYM": [faker.user_name()]
        })
        df = pd.concat([df, entity], ignore_index=True)
    df.to_csv(os.path.join(path, 'artists1.csv'), index=False)
    print('Artists generated')
