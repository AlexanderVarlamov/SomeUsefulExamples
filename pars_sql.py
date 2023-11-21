"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 16.11.2023
@time 16:28
"""
import json

from sqlglot import parse_one, exp
from sqlglot.optimizer import optimize
from sqltree.api import sqltree
from sqltree.dialect import DEFAULT_DIALECT

# # print all column references (a and b)
# for column in parse_one("SELECT a, b + 1 AS c FROM d").find_all(exp.Column):
#     print(column.alias_or_name)
#
# # find all projections in select statements (a and c)
# for select in parse_one("SELECT a, b + 1 AS c FROM d").find_all(exp.Select):
#     for projection in select.expressions:
#         print(projection.alias_or_name)
#
# # find all tables (x, y, z)
# for table in parse_one("SELECT * FROM x JOIN y JOIN z").find_all(exp.Table):
#     print(table.name)

with open("sql_to_parse.sql", "r") as file:
    content = file.read()

parsed_one = parse_one(content, read="postgres")

content1 = "WITH cx as (SELECT col1, col2 FROM table1 as rt) SELECT a, b + 1 AS c FROM d WHERE a>4 and other between 4 and 8"
jsn = '['
for num, table in enumerate(parsed_one.find_all(exp.Table)):
    jsn += "{"
    jsn += f'"id": {num}, \n'
    # jsn += "{"
    jsn += f'\t"name": "{table.name}",\n'
    jsn += f'\t"alias": "{table.alias_or_name}"'
    jsn += "}\n,"
    # print(f"name={table.name}")
    # print(f"alias={table.alias_or_name}")

final_jsn= jsn[:-1]+"]"
with open("res_sql.json", "w") as file:
    file.write(final_jsn)

dct = json.loads(final_jsn)
jsn2 = json.dumps(dct, indent=2)
with open("res_sql.json", "w") as file:
    file.write(jsn2)

opt = optimize(parsed_one).sql(pretty=True)

# print(opt)

for i in parsed_one.find_all(exp.Predicate):
    print(i)