import math as m


def main(b, n, a):
    smbk = 0
    for k in range(1, n + 1):
        for j in range(1, b + 1):
            smbk += 75 * (22 * k ** 2 - 51 - 69 * j) + m.ceil(k) ** 4
    smab = 0
    for j in range(1, a + 1):
        for i in range(1, b + 1):
            smab += (abs(j/19) ** 4 + 0.01 + 97*i**2)
    return smbk - smab
