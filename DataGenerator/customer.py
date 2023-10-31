import os
import random
import pandas as pd
from faker import Faker
from constants import CUSTOMER_NUMBER
from constants import CUSTOMER_UPDATE_NUMBER

path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'Data')

faker = Faker()
subscription_type = ['paid', 'free']


def generate_customers():
    print('Customers generation start')
    df = pd.DataFrame(columns=['NAME', 'SURNAME', 'BIRTH_DATE', 'EMAIL', 'PHONE_NUMBER', 'LOGIN', 'SUBSCRIPTION'])
    for _ in range(CUSTOMER_NUMBER):
        entity = pd.DataFrame({
            "NAME": [faker.first_name()],
            "SURNAME": [faker.last_name()],
            "BIRTH_DATE": [faker.date_of_birth(minimum_age=18).strftime('%Y-%m-%d')],
            "PHONE_NUMBER": [faker.phone_number()],
            "EMAIL": [faker.ascii_email()],
            "LOGIN": [faker.user_name()],
            "SUBSCRIPTION": [random.choice(subscription_type)]
        })
        df = pd.concat([df, entity], ignore_index=True)
    df.to_csv(os.path.join(path, 'customers1.csv'), index=False)
    print('Customers generated')


def update_customers():
    df = pd.read_csv(os.path.join(path, 'customers2.csv'))
    for i in range(CUSTOMER_UPDATE_NUMBER):
        if df.loc[i]['SUBSCRIPTION'] == 'paid':
            df.at[i, 'SUBSCRIPTION'] = 'free'
        else:
            df.at[i, 'SUBSCRIPTION'] = 'paid'
    df.to_csv(os.path.join(path, 'customers2.csv'), index=False)
