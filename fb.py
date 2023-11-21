"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 14.08.2023
@time 15:17
"""
from abc import ABC, abstractmethod


def find_key(val: int):
    if val % 12 == 0:
        return '12'
    elif val % 4 == 0:
        return '4'
    elif val % 3 == 0:
        return '3'
    else:
        return 'default'


class Divider(ABC):
    @abstractmethod
    def print(self, val):
        pass


class Divide:
    def __init__(self, val, divider: Divider):
        divider.print(val)


class Divider12(Divider):
    def print(self, val):
        print('FeezBuzz')


class Divider3(Divider):
    def print(self, val):
        print('Feez')


class Divider4(Divider):
    def print(self, val):
        print('Buzz')


class DefaultDivider(Divider):
    def print(self, val):
        print(val)


methods: dict[str, Divider] = {
    "3": Divider3(),
    "4": Divider4(),
    "12": Divider12(),
    "default": DefaultDivider()
}

if __name__ == '__main__':
    for i in range(1, 101):
        key = find_key(i)
        divider = methods[key]
        Divide(i, divider)
