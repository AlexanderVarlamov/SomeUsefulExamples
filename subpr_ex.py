import math
import threading
import subprocess
import sys


def sub_thread():
    cmd = """
print("Start")
import time
time.sleep(2)
print("Subprocess finished")
    """

    process = subprocess.Popen([sys.executable, "-c", cmd])
    listing = process.communicate()
    [print(line) for line in listing]


def print_thread():
    import time
    time.sleep(0.1)
    print("In the middle")


t1 = threading.Thread(target=sub_thread)
t2 = threading.Thread(target=print_thread)

t1.start()
t2.start()

t1.join()
t2.join()

print("The end!")
