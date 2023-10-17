"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 14.09.2023
@time 14:45
"""
import math
import time
from multiprocessing import Process


rr = range(100000, 105000)
arr = [0.0]*5000


def sq(i):
    math.pow(i, 10)

if __name__ == '__main__':

    nw = time.perf_counter_ns()
    res = 0
    for i in rr:
        res = math.pow(i, 10)
    else:
        print(res)

    print((time.perf_counter_ns()-nw)/1_000_000_000)

    processes = []

    nw = time.perf_counter_ns()

    for i in rr:
        process = Process(target=sq, args=(i,))
        processes.append(process)

    for proc in processes:
        proc.start()

    for proc in processes:
        proc.join()

    print((time.perf_counter_ns()-nw)/1_000_000_000)

