import psycopg2


con = psycopg2.connect(host='localhost', port=5432, user='postgres', password='123', database='sql_practice')

with con.cursor() as cur:
    cur.execute("select * from conference where exists(select null from conference limit 1)")
    res = cur.description


[print(line[0]) for line in res]

input()
