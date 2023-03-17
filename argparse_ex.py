import argparse
from typing import Iterable
parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('integers', metavar='N', type=int, nargs='*',
                    help='an integer for the accumulator')
parser.add_argument('--sum', dest='accumulate', action='store_const',
                    const=sum, default=max,
                    help='sum the integers (default: find the max)')

args = parser.parse_args("5 6 7 --sum".split())
print(args)
print(args.accumulate(args.integers))
print(args.accumulate(args.integers))


