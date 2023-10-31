import os
import random
import pandas as pd
from faker import Faker
from constants import PLAYBACK_NUMBER
from constants import CUSTOMER_NUMBER
from constants import TRACK_NUMBER

path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Data')

faker = Faker()
playlist_tracks = pd.read_csv(os.path.join(path, 'playlistTracks2.csv'))


def generate_playlist_track(track_id):
    if random.random() < 0.15:
        return None, None
    filtered_playlist_tracks = playlist_tracks[playlist_tracks['ID_T'] == track_id]
    if filtered_playlist_tracks.empty:
        return None, None
    random_playlist = filtered_playlist_tracks.sample()
    return random_playlist.loc[random_playlist.index]['ID_T'].to_numpy()[0], random_playlist.loc[random_playlist.index]['ID_P'].to_numpy()[0]


def generate_playbacks():
    print('Playbacks generation start')
    df = pd.DataFrame(columns=['DATE', 'DEVICE', 'ID_C', 'ID_T', 'ID_P', 'ID_PT'])
    for i in range(PLAYBACK_NUMBER):
        track_id = random.randint(1, TRACK_NUMBER)
        playlist_track_id, playlist_id = generate_playlist_track(track_id)
        entity = pd.DataFrame({
            "DATE": [faker.date()],
            "DEVICE": [faker.company()],
            "ID_C": [random.randint(1, CUSTOMER_NUMBER)],
            "ID_T": [track_id],
            "ID_P": [playlist_id],
            "ID_PT": [playlist_track_id]
        })
        df = pd.concat([df, entity], ignore_index=True)
        if i % 50000 == 0:
            print('Playbacks generated: ', i)
            df.to_csv(os.path.join(path, 'playbacks1.csv'), index=False)
    df.to_csv(os.path.join(path, 'playbacks1.csv'), index=False)
    print('Playbacks generated')
