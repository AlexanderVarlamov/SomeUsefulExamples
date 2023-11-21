"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 16.11.2023
@time 16:28
"""
import json
import re
from typing import List, Optional

from sqlglot import parse_one, exp
from sqlglot.optimizer import optimize

FILENAME = "sql_to_parse.sql"

PREDICATES_DICT = {
    "=": "eq",
    "<>": "ne",
    "!=": "ne",
    ">": "gt",
    "<": "lt",
    "<=": "le",
    ">=": "ge",
    "is": "is",
    "is not": "is not"

}

keys = {}
result = {}


def find_predicates(filename: str):
    with open("sql_to_parse.sql", "r") as file:
        content = file.read()

    parsed_one = optimize(parse_one(content, read="postgres"), dialect="oracle")
    with open("optimized.sql", "w") as file:
        file.write(parsed_one.sql(pretty=True))

    for table in parsed_one.find_all(exp.Table):
        keys.update({table.alias_or_name.lower(): table.name.lower()})
        result.update({table.name.lower(): {"alias": table.alias_or_name.lower(), "predicates": []}})

    predicates: list[str] = []
    for join_or_where in parsed_one.find_all(exp.Join, exp.Where):
        for pred in join_or_where.find_all(exp.Predicate):
            predicates.append(pred.sql().replace('"', '').lower())

    return predicates


def find_column_dependencies(txt_predicates) -> Optional[List[str]]:
    maybe_literals = []
    regex = r"(?P<alias_main>[a-z0-9_]+).(?P<column>[a-z0-9_]+)\s+(?P<predicate>[=<>]{1,2})\s+(?P<alias_depends>[a-z0-9_]+).(?P<column_depends>[a-z0-9_]+)"
    for predicate in txt_predicates:
        m = re.match(regex, predicate)
        if m:
            if m.group("alias_main") in keys:
                table_name = keys[m.group("alias_main")]
                column = m.group("column")
                pred = PREDICATES_DICT[m.group("predicate")] if m.group("predicate") in PREDICATES_DICT else "n/a"
                alias_depends = keys[m.group("alias_depends")]
                column_depends = m.group("column_depends")
                result[table_name]["predicates"].append(
                    {"column": column, "predicate": pred, "depends_on": f"{alias_depends}.{column_depends}"})
                result[alias_depends]["predicates"].append(
                    {"column": column_depends, "predicate": pred, "depends_on": f"{table_name}.{column}"}
                )
        else:
            maybe_literals.append(predicate)

    return maybe_literals


def find_literal_dependencies(maybe_literals: List[str]) -> Optional[List[str]]:
    remains = []
    regex = "(?P<alias_main>[a-z0-9_]+).(?P<column>[a-z0-9_]+)\s+(?P<predicate>is not|is|[!=<>]{1,2})\s+(?P<literal>[a-z|0-9_]+)"

    for predicate in maybe_literals:
        m = re.match(regex, predicate)
        if m:
            if m.group("alias_main") in keys:
                table_name = keys[m.group("alias_main")]
                column = m.group("column")
                pred = PREDICATES_DICT[m.group("predicate")] if m.group("predicate") in PREDICATES_DICT else "n/a"
                literal = m.group("literal")
                result[table_name]["predicates"].append({"column": column, "predicate": pred, "depends_on": literal})
        else:
            remains.append(predicate)

    return remains


if __name__ == "__main__":
    txt_predicates = find_predicates(FILENAME)
    maybe_literals = find_column_dependencies(txt_predicates)
    remains = find_literal_dependencies(maybe_literals)
    result.update({"remains": remains})
    jsn = json.dumps(result, indent=2)
    print(jsn)

    with open("res_sql.json", "w") as file:
        file.write(jsn)
