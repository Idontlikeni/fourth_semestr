import math as m


def main(n):
    if n == 0:
        return -0.48
    elif n >= 1:
        m = main(n-1)
        return 1 - 2 * m ** 2 - (2 * m ** 3 - m) ** 3
