"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 15.08.2023
@time 9:34
"""
def score(cf, *scores):
    print(scores)
    for i in scores:
        print(cf*i)


cf = 0.2
scores = [4, 5, 4]

score(cf, *scores)