from math import asin, sqrt, atan


def main(x, z, y):
    return sqrt(((asin(z + 1 + (y ** 2 / 10))) ** 6 + 83 * x) / (
            32 * (atan(63 * (x ** 2)) ** 4) - 51 *
            (18 * (x ** 2) - z - y ** 3) ** 3)) + (
            (63 * ((z + z ** 3 + 1) ** 7)) +
            (y / 71 - 83 * (x ** 2)) ** 6) / (
            atan(x) ** 3 + (y ** 3 - 39 - 54 * (z ** 2)) ** 7)


print(main(-0.12, -0.94, 0.02))
print(main(-0.59, -0.72, -0.37))
print(main(-0.31, -0.68, 0.93))
print(main(-0.6, -0.98, 0.23))
print(main(-0.31, -0.08, 0.08))

# def main(x, z, y):
#     a = ((asin(z + 1 + (y ** 2 / 10))) ** 6 + 83 * x)
#     b = (32 * (atan(63 * (x ** 2)) ** 4) - 51 *
#          (18 * (x ** 2) - z - y ** 3) ** 3)
#     r1 = sqrt(a / b)
#     c = 63 * ((z + z ** 3 + 1) ** 7) + (y / 71 - 83 * (x ** 2)) ** 6
#     d = atan(x) ** 3 + (y ** 3 - 39 - 54 * (z ** 2)) ** 7
#     r2 = (c / d)
#     r_ovr = r1 + r2
#     return r_ovr
