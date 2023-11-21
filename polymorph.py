"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 14.08.2023
@time 11:20
"""


class Borg:
    _shared_state = {"1": "2"}

    def __new__(cls, *args, **kwargs):
        instance = super().__new__(cls)
        instance.__dict__ = cls._shared_state
        return instance



b = Borg()
print("Object State 'b':", b.__dict__)  ## b and b1 share same state
b1 = Borg()
b.x = 4

print("Borg Object 'b': ", b)  ## b and b1 are distinct objects
print("Borg Object 'b1': ", b1)
print("Object State 'b':", b.__dict__)  ## b and b1 share same state
print("Object State 'b1':", b1.__dict__)
