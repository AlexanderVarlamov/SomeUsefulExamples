def show_exceptions(value):
    assert value >= 0, "Поданное число отрицательное"
    assert value < 101, "Поданное число больше 100"
    return value*2


show_exceptions(4)
try:
    show_exceptions(400)
except AssertionError as e:
    print(e)
show_exceptions(-600)

print("конец")