import math


def main(x, y):
    return math.sqrt(x ** 7 - 74 * y ** 6) - \
           math.sqrt(((68 * y + y*y + 55 * x ** 3) ** 5) /
                     (y**6/65 + 75*(69*x*x)**5))
