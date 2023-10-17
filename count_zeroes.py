"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 01.09.2023
@time 12:26
"""
# number = '1000500'
number = '0'

start, finish = 0, len(number)-1

for i in range(len(number)):
    if number[i] != '0':
        start = i
        break

for i in range(len(number)-1, start-1, -1):
    if number[i] != '0':
        finish = i
        break

numb_for_count = number[start:finish]

print(numb_for_count.count('0'))
print((number.strip('0')).count('0'))

import math

print(pow(2, 3, 3))