import re
from functools import reduce
from typing import List
import cProfile

def readfile() -> str:
    with open("./resources/sql_with_comments.sql", "r") as file:
        return file.read().upper().replace("\n", " ")


def single_cte_processing(sql_string: str) -> dict:
    with1_sql = sql_string.upper().replace("\n", " ")
    regex_to_find = r'(?P<cte_name>[a-zA-Z_]+) .+SELECT(?P<select_part>.+)FROM (?P<table_name>[a-zA-Z0-9_.]+) (' \
                    r'?P<alias_name>[a-zA-Z_])'
    groups = re.search(regex_to_find, with1_sql)
    cte_name, table_name, alias_name = groups["cte_name"], groups["table_name"], groups["alias_name"]
    to_substitute = {alias_name: table_name}

    select_part = groups["select_part"]
    column_names = list(map(lambda x: x.strip(), select_part.split(",")))

    for i in range(len(column_names)):
        column = column_names[i]
        db, table = column.split(".")
        if db in to_substitute:
            db = table_name
        column = ".".join([db, table])
        column_names[i] = column

    return {cte_name: column_names}


def create_list_of_cte_s(sql: str) -> List[str]:
    _, _, after_with = sql.partition("WITH")
    position_of_last_select: int = after_with.rfind("SELECT")
    cte_string: str = after_with[:position_of_last_select]
    cte_s: List[str] = list(map(lambda x: x.strip(), re.findall(r' *\w+ *AS *\( +[\w .,=\')]+\),*', cte_string)))
    return cte_s


def columns_string_processing(columns_string: str) -> List[str]:
    raw_columns: List[str] = columns_string.split(",")
    result = list(map(lambda x: re.match(r"\w+", x.strip()).group(0), raw_columns))
    return result


def last_select_processing(sql: str, res: dict) -> None:
    # TODO complete this function
    groups = re.search(r"SELECT +(?P<columns>.+)FROM +(?P<table_name>\w+) .+", sql)
    columns_string, table_name = groups['columns'], groups['table_name']

    if table_name in res:
        index_of_second_point = res[table_name][0].rfind(".")
        table_name = res[table_name][0][:index_of_second_point]
    else:
        pass

    columns = columns_string_processing(columns_string)
    final_columns = list(map(lambda x: table_name + "." + x, columns))
    res.update({"FINAL_SELECT": final_columns})



def main():
    content = readfile()
    cte_s = create_list_of_cte_s(content)
    res = reduce(lambda x, y: {**x, **single_cte_processing(y)}, cte_s, {})
    print(res)

    last_select_position = content.rfind("SELECT")
    last_select = content[last_select_position:]
    last_select_processing(last_select, res)
    print(res)


if __name__ == "__main__":
    cProfile.run("main()", sort="cumtime")
