#!/usr/bin/python3

import sys

with open(sys.stdin.fileno(), 'r', errors="ignore") as f:
    print(bool('False'))
    for line in f:
        line = line.strip()
        words = line.split()
        for word in words:
            print('%s\t%s' % (word, 1))
