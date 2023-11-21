"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 23.08.2023
@time 12:18
"""
import json
import random as r
import time
from datetime import datetime

import psycopg2
from kafka import KafkaProducer, KafkaConsumer

KAFKA_SERVER = 'vm-strmng-s-1.test.local'
TOPIC_NAME = 'varlamov_clients'
NUMBER_OF_MESSAGES = 1000

clients = ["Иванов", "Петров", "Сидоров", "Валиев", "Мельниченко", "Бочкарев", "Белозерцев"]


def get_priority(num: float):
    if num <= 0.75:
        return 0
    elif num <= 0.95:
        return 1
    else:
        return 2


def fill_the_kafka():
    producer = KafkaProducer(bootstrap_servers=KAFKA_SERVER)

    try:
        for _ in range(NUMBER_OF_MESSAGES):
            priority = get_priority(r.random())
            new_client = f'''
            {{"client": "{r.choice(clients)}",
            "opened": "{datetime.now()}",
            "priority": {priority}}}'''
            client_enc = new_client.encode('utf-8')
            producer.send(topic=TOPIC_NAME, value=client_enc)
    except Exception:
        raise
    finally:
        producer.close()
        print("producer's produced")


def read_from_kafka() -> dict:
    dict_of_messages = {'lab10_varlamov_0': [], 'lab10_varlamov_1': [], 'lab10_varlamov_2': []}
    dict_of_priority = {0: 'lab10_varlamov_0', 1: 'lab10_varlamov_1', 2: 'lab10_varlamov_2'}
    consumer = KafkaConsumer(TOPIC_NAME,
                             bootstrap_servers=KAFKA_SERVER,
                             auto_offset_reset='earliest',
                             enable_auto_commit=False,
                             consumer_timeout_ms=1000)

    for msg in consumer:
        new_message: dict = json.loads(msg.value.decode('utf-8'))
        priority = new_message.get('priority')
        if priority in dict_of_priority.keys():
            tablename = dict_of_priority[priority]
            dict_of_messages[tablename].append(new_message)

    consumer.close()
    print("consumer's consumed")
    return dict_of_messages


def get_sqls(msg_dict: dict) -> list:
    list_of_sqls = []
    for key in msg_dict.keys():
        raw_sql = f'INSERT INTO {key} VALUES'
        for single_client in msg_dict[key]:
            client = single_client.get('client')
            opened = single_client.get('opened')
            priority = single_client.get('priority')

            if client is None or opened is None or priority is None:
                continue

            values_string = f"('{client}', '{opened}', {priority}),"
            raw_sql += values_string
        sql_to_execute = raw_sql[:-1]

        if msg_dict[key]:
            list_of_sqls.append(sql_to_execute)
    print('sqls are ready')
    return list_of_sqls


def execute_sqls(lst_of_slqs: list):
    con = psycopg2.connect(host='192.168.77.21', port=5432, user='varlamov', password='nrg3z', database='postgres')
    try:
        with con.cursor() as cur:
            for sql in lst_of_slqs:
                cur.execute(sql)
                con.commit()
    except Exception:
        con.rollback()
        raise
    finally:
        con.close()
        print('tables are filled')


if __name__ == '__main__':
    fill_the_kafka()
    time.sleep(1)
    dict_of_messages = read_from_kafka()
    time.sleep(1)
    slqs = get_sqls(dict_of_messages)
    time.sleep(1)
    execute_sqls(slqs)
    print('etl is done')
