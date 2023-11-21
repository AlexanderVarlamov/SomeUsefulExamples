"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 14.08.2023
@time 16:41
"""
import random


class Single:
    _instance = None

    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            instance = super().__new__(cls)
            instance.rnd = random.randint(1, 100)
            cls._instance = instance

        return cls._instance


    def __call__(self):
        print(self.rnd)


s1 = Single()
s2 = Single()
s3 = Single()

s1()
s2()
s3()

