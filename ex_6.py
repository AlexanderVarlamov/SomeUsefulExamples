"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 04.08.2023
@time 16:50
"""
import random as r

import psycopg2

con = psycopg2.connect(host='192.168.77.21', port=5432, user='varlamov', password='nrg3z', database='postgres')

sites = ['www.vk.com', 'www.yandex.ru', 'www.ok.ru', 'www.rbc.ru']

start_sql = 'INSERT INTO TABLE users_log_varlamov VALUES\n'

for i in range(10000):
    user_id = r.randint(1, 10)
    web_site = r.choice(sites)
    bytes = r.randint(0, 10000)
    string_to_append = f"({user_id}, {web_site}, {bytes}),\n"
    start_sql += string_to_append

sql = start_sql[:-2]
with con.cursor() as cur:
    cur.execute(sql)

con.commit()
con.close()
