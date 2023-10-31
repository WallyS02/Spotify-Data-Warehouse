import os
import random
import pandas as pd
from faker import Faker
from constants import ALBUM_NUMBER
from constants import ARTISTS_NUMBER

path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Data')

faker = Faker()


def generate_albums():
    print('Albums generation start')
    df = pd.DataFrame(columns=['TITLE', 'LENGTH', 'RELEASE_DATE', 'ID_A'])
    for _ in range(ALBUM_NUMBER):
        entity = pd.DataFrame({
            "TITLE": [faker.word().capitalize() + " " + faker.word().capitalize()],
            "LENGTH": [faker.time()],
            "RELEASE_DATE": [faker.date()],
            "ID_A": [random.randint(1, ARTISTS_NUMBER)]
        })
        df = pd.concat([df, entity], ignore_index=True)
    df.to_csv(os.path.join(path, 'albums1.csv'), index=False)
    print('Albums generated')
