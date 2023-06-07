import psycopg2


con = psycopg2.connect(host='localhost', port=5432, user='postgres', password='123', database='sql_practice')

with con.cursor() as cur:
    cur.execute("select * from nosql.planet limit 5")
    res = cur.description
    cont = cur.fetchall()


[print(line[0], end="\t") for line in res]
print()
[print(line) for line in cont]
print(float(cont[0][2]))


