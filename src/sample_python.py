import numpy as np


def split_array():
    print("Run sample python code ...")
    array = np.floor(10*np.random.random((2,15)))
    a = np.hsplit(array, 3)
    print(array)
    print(a)
