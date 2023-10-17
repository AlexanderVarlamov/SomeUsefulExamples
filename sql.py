"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 31.08.2023
@time 14:57
"""
MESSAGE = 'fwefew fdsf прпар '
sql = fr"insert into lab10_varlamov(message) values ('{MESSAGE}'||E'\xF0\x9F\x98\xB8');"

print(sql)

import requests

send_text = f'https://api.telegram.org/bot6269958264:AAEdScLrCgcphW2G16PbUjnqbmGe-kdRWU8/sendMessage?chat_id=-942581515&parse_mode=Markdown&text={MESSAGE}\U0001F638'
new_text = send_text.replace(' ', '%20')
requests.get(new_text)