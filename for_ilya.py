"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 24.11.2023
@time 11:01
"""
from string import ascii_lowercase


class CommonWords:
    def __init__(self, length):
        self.remember_rand_word(length)

    def remember_rand_word(self, length):
        import random as r
        string_to_choice = ascii_lowercase
        xxx = ""
        for _ in range(length):
            xxx += r.choice(string_to_choice)

        self.rand_word = xxx


class ConcreteWord(CommonWords):
    length = 9

    def __init__(self):
        super().__init__(ConcreteWord.length)
        # и с этого момента у тебя будет существовать параметр self.rand_word
        print(self.rand_word)


cw = ConcreteWord()
print(cw.rand_word)

class SecWord:
    def __init__(self, cw: ConcreteWord):
        self.rand_word = cw.rand_word
        print(self.rand_word)



sw = SecWord(cw)
