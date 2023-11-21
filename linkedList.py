"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 17.08.2023
@time 9:47
"""


class LinkedList:
    def __init__(self, head=None, tail=None):
        self.head = head
        self.tail = tail
        if self.head is None:
            self.last = True
            self.tail = None
        else:
            self.last = False

    def __iter__(self):
        return self

    def __next__(self):
        if self.last:
            raise StopIteration
        else:
            value = self.head
            tail = self.tail
            if tail is None:
                self.last = True
                self.head = None
                self.tail = None
            else:
                self.head = tail.head
                self.tail = tail.tail
            return value

    def __repr__(self):
        return f"{self.head} {self.tail}"


def symmDiff(set1: set, set2: set):
    result = set1.copy()

    for elem in set2:
        if elem not in result:
            result.add(elem)
        else:
            result.remove(elem)

    return result


ll = LinkedList(1, LinkedList(2, LinkedList(3)))
ll2 = LinkedList(11)
ll3 = LinkedList()
for elem in ll:
    print(elem)

set1 = {1, 3, 0}
set2 = {7, 0, 3}

print(symmDiff(set1, set2))
