import os
import random
import pandas as pd
from faker import Faker
from constants import PLAYBACK_NUMBER
from constants import CUSTOMER_NUMBER
from constants import TRACK_NUMBER

path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Data')

faker = Faker()
device_types = ['mobile', 'desktop', 'web application']


def generate_playbacks():
    print('Playbacks generation start')
    df = pd.DataFrame(columns=['DATE', 'DEVICE', 'LISTENING_TIME', 'ID_C', 'ID_T'])
    for i in range(PLAYBACK_NUMBER):
        track_id = random.randint(1, TRACK_NUMBER)
        entity = pd.DataFrame({
            "DATE": [faker.date_time()],
            "DEVICE": [random.choice(device_types)],
            "LISTENING_TIME": [faker.time()],
            "ID_C": [random.randint(1, CUSTOMER_NUMBER)],
            "ID_T": [track_id]
        })
        df = pd.concat([df, entity], ignore_index=True)
    df.to_csv(os.path.join(path, 'playbacks1.csv'), index=False)
    print('Playbacks generated')
