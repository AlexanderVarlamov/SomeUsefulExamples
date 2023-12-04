import sqlparse

# Ваш SQL скрипт
sql_script = """
-- ваш SQL скрипт здесь
"""

FILENAME = "script1.sql"

with open(FILENAME, "r") as file:
    sql_script = file.read()

# Функция для извлечения всех условий WHERE и операций JOIN
def extract_conditions(sql_script):
    parsed = sqlparse.parse(sql_script)

    # Перебираем каждый запрос
    for statement in parsed:
        # Извлекаем условия WHERE
        where_conditions = [token.value for token in statement.tokens if token.ttype in sqlparse.tokens.]

        # Извлекаем операции JOIN
        join_conditions = [token.value for token in statement.tokens if token.ttype in sqlparse.tokens.Punctuation and token.value.upper() == 'JOIN']

        print("WHERE условия:")
        for condition in where_conditions:
            print(condition)

        print("\nJOIN условия:")
        for condition in join_conditions:
            print(condition)

# Вызываем функцию извлечения условий
extract_conditions(sql_script)