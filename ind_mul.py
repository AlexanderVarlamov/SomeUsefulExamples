"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 02.10.2023
@time 15:05
"""
def found_indexes(numbers: list, target: int) -> list:
    map_of_indexes = {}
    if target == 0:
        if numbers.count(0) > 0:
            index_of_null = numbers.index(0)
            return [[index_of_null, i] for i in range(len(numbers)) if i != index_of_null][0]
        else:
            return []
    for i in range(len(numbers)):
        current = numbers[i]
        compl = target/current
        if compl in map_of_indexes:
            return [map_of_indexes[compl], i]
        else:
            map_of_indexes[current] = i

    return []


assert found_indexes([2, 3, 5, 10], 15) == [1, 2]
assert found_indexes([2, 3, 5, 10], 16) == []
assert set(found_indexes([2, 3, 5, 0], 0)) == {0, 3}, found_indexes([2, 3, 5, 0], 0)

a = 999
b = 998 + 1
print(a is b)
print(round(0.3-0.2, 2))
#1232
#224145kl34534
#gfgdffdfgsd