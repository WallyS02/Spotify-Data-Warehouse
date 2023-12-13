import os
import random
import pandas as pd
from faker import Faker
from constants import TRACK_NUMBER
from constants import ALBUM_NUMBER

path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Data')

faker = Faker()


def generate_tracks():
    print('Tracks generation start')
    df = pd.DataFrame(columns=['TITLE', 'LENGTH', 'NUMBER_IN_ALBUM', 'ID_A'])
    for _ in range(TRACK_NUMBER):
        entity = pd.DataFrame({
            "TITLE": [faker.word().capitalize() + " " + faker.word().capitalize()],
            "LENGTH": [faker.time()],
            "NUMBER_IN_ALBUM": [random.randint(1, 25)],
            "ID_A": [random.randint(1, ALBUM_NUMBER)]
        })
        df = pd.concat([df, entity], ignore_index=True)
    df.to_csv(os.path.join(path, 'tracks1.csv'), index=False)
    print('Tracks generated')


def expand_tracks():
    print('Tracks generation start')
    df = pd.read_csv(os.path.join(path, 'tracks1.csv'))
    for _ in range(TRACK_NUMBER):
        entity = pd.DataFrame({
            "TITLE": [faker.word().capitalize() + " " + faker.word().capitalize()],
            "LENGTH": [faker.time()],
            "NUMBER_IN_ALBUM": [random.randint(1, 25)],
            "ID_A": [random.randint(1, ALBUM_NUMBER)]
        })
        df = pd.concat([df, entity], ignore_index=True)
    df.to_csv(os.path.join(path, 'tracks2.csv'), index=False)
    print('Tracks generated')
