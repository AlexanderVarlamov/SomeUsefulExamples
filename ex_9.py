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

APP_ID = [10000, 10001, 10002]

start_sql = 'INSERT INTO TABLE lab9_recom__new_varlamov VALUES\n'

for i in range(3):
    app_id = r.choice(APP_ID),
    helpful = r.randint(1, 1000)
    funny = r.randint(1, 1000)
    date = f"2023-{r.randint(1, 12)}-{r.randint(1, 28)}"
    is_recommended = r.choice([True, False])
    hours = r.random()*1000
    user_id = r.randint(1, 1000)
    review_id = r.randint(1, 1000)
    string_to_append = f"({app_id[0]}, {helpful}, {funny}, {date}, {is_recommended}, {hours}, {user_id}, {review_id}),\n"
    start_sql += string_to_append

sql = start_sql[:-2]
with con.cursor() as cur:
    cur.execute(sql)

con.commit()
con.close()
