import os
import random
import pandas as pd
from faker import Faker
from constants import PLAYLIST_NUMBER
from constants import CUSTOMER_NUMBER
from constants import PLAYLIST_UPDATE_NUMBER

path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Data')

faker = Faker()
privacy_type = ['private', 'public']


def generate_playlists():
    print('Playlists generation start')
    df = pd.DataFrame(columns=['NAME', 'CREATION_DATE', 'PRIVACY', 'LENGTH', 'ID_C'])
    for _ in range(PLAYLIST_NUMBER):
        entity = pd.DataFrame({
            "NAME": [faker.word().capitalize() + " " + faker.word().capitalize()],
            "CREATION_DATE": [faker.date_between()],
            "PRIVACY": [random.choice(privacy_type)],
            "LENGTH": [faker.time()],
            "ID_C": [random.randint(1, CUSTOMER_NUMBER)],
        })
        df = pd.concat([df, entity], ignore_index=True)
    df.to_csv(os.path.join(path, 'playlists1.csv'), index=False)
    print('Playlists generated')


def update_playlists():
    df = pd.read_csv(os.path.join(path, 'playlists2.csv'))
    for i in range(PLAYLIST_UPDATE_NUMBER):
        if df.at[i, 'PRIVACY'] == 'private':
            df.at[i, 'PRIVACY'] = 'public'
        else:
            df.at[i, 'PRIVACY'] = 'private'
        df.at[i, 'LENGTH'] = faker.time()
    df.to_csv(os.path.join(path, 'playlists2.csv'), index=False)


def expand_playlists():
    print('Playlists generation start')
    df = pd.read_csv(os.path.join(path, 'playlists1.csv'))
    for _ in range(PLAYLIST_NUMBER):
        entity = pd.DataFrame({
            "NAME": [faker.word().capitalize() + " " + faker.word().capitalize()],
            "CREATION_DATE": [faker.date_between()],
            "PRIVACY": [random.choice(privacy_type)],
            "LENGTH": [faker.time()],
            "ID_C": [random.randint(1, CUSTOMER_NUMBER)],
        })
        df = pd.concat([df, entity], ignore_index=True)
    df.to_csv(os.path.join(path, 'playlists2.csv'), index=False)
    print('Playlists generated')
