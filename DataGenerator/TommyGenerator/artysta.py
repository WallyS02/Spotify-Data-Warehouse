import pandas as pd
from faker import Faker
import random

fake = Faker()

liczba_rekordow = 250000

id = []
kraj = []
liczba_obserwujacych = []
liczba_utworow = []
gatunek = []
data_debiutu = []
liczba_godzin = []
srednia_dlugosc = []

gatunki_piosenek = ["Pop", "Rock", "Hip-hop", "R&B", "Jazz", "Reggae", "Country", "Metal", "Electro", "Indie"]

existing_ids = set()
min = 1
max = liczba_rekordow
def generowanie_unique_id(min, max, existing_ids):
    if len(existing_ids) >= liczba_rekordow:
        return 0
    while True:
        random_id = random.randint(min, max)
        if random_id not in existing_ids:
            existing_ids.add(random_id)
            return random_id


def dodawanie_rekordow(id,kraj,liczba_obserwujacych,liczba_utworow,gatunek,data_debiutu,liczba_godzin,srednia_dlugosc,liczba_rekordow):
    for i in range(liczba_rekordow):
        unique_id = generowanie_unique_id(min, max, existing_ids)
        id.append(unique_id)
        existing_ids.add(unique_id)
        kraj.append(fake.country())
        liczba_obserwujacych.append(random.randint(1000, 1000000))
        liczba_utworow.append(random.randint(1, 1000))
        gatunek.append(gatunki_piosenek[random.randint(0, len(gatunki_piosenek) - 1)])
        data_debiutu.append(fake.date_between(start_date='-5y', end_date='-1y'))
        srednia_dlugosc.append(random.uniform(1,5))
        liczba_godzin.append(srednia_dlugosc[i]*liczba_utworow[i])

    dane = {
        'ID': id,
        'Kraj': kraj,
        'Liczba obserwujących': liczba_obserwujacych,
        'Liczba utworów': liczba_utworow,
        'Gatunek': gatunek,
        'Data debiutu': data_debiutu,
        'Liczba godzin': liczba_godzin,
        'Średnia długość': srednia_dlugosc
    }
    return dane

dane = dodawanie_rekordow(id,kraj,liczba_obserwujacych,liczba_utworow,gatunek,data_debiutu,liczba_godzin,srednia_dlugosc,liczba_rekordow)
df = pd.DataFrame(dane)
df.to_csv('dane_artysta1.csv', index=False)
print("Dane zostały zapisane.")

def modyfikuj_losowe_elementy(df, wspolczynnik_modyfikacji):
    liczba_elementow_do_modyfikacji = int(len(df) * wspolczynnik_modyfikacji)
    elementy_do_modyfikacji = random.sample(range(len(df)), liczba_elementow_do_modyfikacji)
    for index in elementy_do_modyfikacji:
        # ID nie zmieniam
        # Kraj się nie zmienia
        df.at[index, 'Liczba obserwujących'] = df.at[index, 'Liczba obserwujących'] + random.randint(100, 1000)  # Dodana wartość obserwujących
        df.at[index, 'Liczba utworów'] = df.at[index, 'Liczba utworów'] + random.randint(1, 10)  # Dodana wartość utworów
        df.at[index, 'Gatunek'] = gatunki_piosenek[random.randint(0, len(gatunki_piosenek) - 1)]  # Wybór nowego gatunku
        # data debiutu nie zmienia się
        df.at[index, 'Średnia długość'] = random.uniform(1,5)  # Nowa średnia długość
        df.at[index, 'Liczba godzin'] = df.at[index, 'Średnia długość'] * df.at[index, 'Liczba utworów']  # Aktualizacja liczby godzin

nowe_rekordy = 70000
liczba_rekordow += nowe_rekordy
max += nowe_rekordy
dane = dodawanie_rekordow(id,kraj,liczba_obserwujacych,liczba_utworow,gatunek,data_debiutu,liczba_godzin,srednia_dlugosc,nowe_rekordy)
df = pd.DataFrame(dane)

modyfikuj_losowe_elementy(df, 0.10)
df.to_csv('dane_artysta2.csv', index=False)
print("Dane zostały zapisane.")