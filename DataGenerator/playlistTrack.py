import os
import random
import pandas as pd
from constants import PLAYLIST_TRACK_NUMBER
from constants import PLAYLIST_NUMBER
from constants import TRACK_NUMBER

path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Data')


def generate_playlist_tracks():
    print('Playlist Tracks generation start')
    df = pd.DataFrame(columns=['ID_P', 'ID_T'])
    for _ in range(PLAYLIST_TRACK_NUMBER):
        entity = pd.DataFrame({
            "ID_P": [random.randint(1, PLAYLIST_NUMBER)],
            "ID_T": [random.randint(1, TRACK_NUMBER)]
        })
        df = pd.concat([df, entity], ignore_index=True)
    df.to_csv(os.path.join(path, 'playlistTracks1.csv'), index=False)
    print('Playlist Tracks generated')
