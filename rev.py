"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 17.08.2023
@time 15:43
"""

inp = input().split()
ans_rev = [inp[i] for i in range(0, len(inp)) if i % 2 != 0]
ans_rev.reverse()
print(*ans_rev)
