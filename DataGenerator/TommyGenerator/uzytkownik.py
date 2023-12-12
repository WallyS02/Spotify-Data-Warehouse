import pandas as pd
from faker import Faker
import random

fake = Faker()

id = []
data_rejestracji = []
gatunek = []
liczba_utworow_biblioteka = []
liczba_obserwujacych = []
ostatnie_logowanie = []
ilosc_dni_premium = []
najczestrze_urzadzenie = []

liczba_rekordow = 3500

gatunki_piosenek = ["Pop", "Rock", "Hip-hop", "R&B", "Jazz", "Reggae", "Country", "Metal", "Electro", "Indie"]
device_types = ['mobile', 'desktop', 'web application']

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

def dadanie_rekorow(id,data_rejestracji,gatunek,liczba_utworow_biblioteka,liczba_obserwujacych,ostatnie_logowanie,ilosc_dni_premium,najczestrze_urzadzenie, liczba_rekordow):
    for _ in range(liczba_rekordow):
        unique_id = generowanie_unique_id(min, max, existing_ids)
        id.append(unique_id)
        existing_ids.add(unique_id)
        data_rejestracji.append(fake.date_between(start_date='-5y', end_date='-1y'))
        gatunek.append(gatunki_piosenek[random.randint(0, len(gatunki_piosenek) - 1)])
        liczba_utworow_biblioteka.append(random.randint(1, 500))
        liczba_obserwujacych.append(random.randint(1, 10000))
        ostatnie_logowanie.append(fake.date_time_between(start_date='-2y', end_date='-1y'))
        ilosc_dni_premium.append(random.randint(0, 5 * 365))
        najczestrze_urzadzenie.append(device_types[random.randint(0, len(device_types) - 1)])

    dane = {
        'ID': id,
        'Data rejestracji': data_rejestracji,
        'Gatunek': gatunek,
        'Liczba utworów w bibliotece': liczba_utworow_biblioteka,
        'Liczba obserwujących': liczba_obserwujacych,
        'Ostatnie logowanie': ostatnie_logowanie,
        'Ilość dni Premium': ilosc_dni_premium,
        'Najczęstsze urządzenie': najczestrze_urzadzenie
    }
    return dane

dane = dadanie_rekorow(id,data_rejestracji,gatunek,liczba_utworow_biblioteka,liczba_obserwujacych,ostatnie_logowanie,ilosc_dni_premium,najczestrze_urzadzenie, liczba_rekordow)
df = pd.DataFrame(dane)
df.to_csv('dane_uzytkownik1.csv', index=False)
print("Dane zostały zapisane.")

def modyfikuj_losowe_elementy(df, wspolczynnik_modyfikacji):
    liczba_elementow_do_modyfikacji = int(len(df) * wspolczynnik_modyfikacji)
    elementy_do_modyfikacji = random.sample(range(len(df)), liczba_elementow_do_modyfikacji)
    for index in elementy_do_modyfikacji:
        #ID nie zmieniam
        #data rejestracji się nie zmienia
        df.at[index, 'Gatunek'] = gatunki_piosenek[random.randint(0, len(gatunki_piosenek) - 1)] #wybór nowego gatunku
        df.at[index, 'Liczba utworów w bibliotece'] = df.at[index, 'Liczba utworów w bibliotece'] + random.randint(1, 100) #dodana wartość utwrow
        df.at[index, 'Liczba obserwujących'] = df.at[index, 'Liczba obserwujących'] + random.randint(1, 500) # dodana wartość obserwójaćych
        df.at[index, 'Ostatnie logowanie'] = fake.date_time_between(start_date='-1y', end_date='now') #nowa data
        df.at[index, 'Ilość dni Premium'] = df.at[index, 'Ilość dni Premium'] + random.randint(0, 365) #dodana ilość dni
        df.at[index, 'Najczęstsze urządzenie'] = device_types[random.randint(0, len(device_types) - 1)] #nowa urządzenie

nowe_rekordy = 3500
liczba_rekordow += nowe_rekordy
max += nowe_rekordy
dane = dadanie_rekorow(id,data_rejestracji,gatunek,liczba_utworow_biblioteka,liczba_obserwujacych,ostatnie_logowanie,ilosc_dni_premium,najczestrze_urzadzenie, nowe_rekordy)
df = pd.DataFrame(dane)

modyfikuj_losowe_elementy(df, 0.10)
df.to_csv('dane_uzytkownik2.csv', index=False)
print("Dane zostały zapisane.")

