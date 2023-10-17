"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 08.06.2023
@time 9:33
"""
from datetime import date

dict1 = {'key1': 6, 'key2': {'key3': 6, 'key4': 8}, 'key5': 45}
dict2 = dict1.copy()

dict1['key2']['key3'] = 7

print(dict1 == dict2)


class Player:
    def __init__(self):
        self.__age = 0

    @property
    def age(self):
        return self.__age

    @age.setter
    def age(self, new_age):
        assert isinstance(new_age, int) and new_age > 0, 'Возраст должен быть целым числом больше 0'
        self.__age = new_age


class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    @classmethod
    def fromBirthYear(cls, name, year):
        return cls(name, date.today().year - year)

    @staticmethod
    def isAdult(age):
        return age > 18

ob = Player()
print(ob.age)
ob.age = 58
print(ob.age)

ttt = Person.fromBirthYear('123', 1987)


class MyClass:
    TOTAL_OBJECTS = 0

    def __init__(self):
        MyClass.TOTAL_OBJECTS = MyClass.TOTAL_OBJECTS + 1

    @staticmethod
    def total():
        print(MyClass.TOTAL_OBJECTS)

    @classmethod
    def total_objects(cls):
        print("Total objects: ", cls.TOTAL_OBJECTS)


# Создаем объекты
my_obj1 = MyClass()
my_obj2 = MyClass()
my_obj3 = MyClass()

my_obj1.total()
MyClass.total_objects()