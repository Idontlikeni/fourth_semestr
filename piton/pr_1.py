import math as m


def main2(n):
    b = bin(int(n, 16))[2:]
    arr = [9, 10, 9, 4, 7, 3]
    c = 0
    y = []
    for i in arr:
        y.append(b[c:c+i])
        c += i
    print(y)
    return int(y[1] + y[4] + y[2] + y[0] + y[3] + y[5], 2)

def main(n):
    m = int(n, 16)
    y = []
    arr = [9, 10, 9, 4, 7, 3]
    arr.reverse()
    for i in arr:
        temp = 2 ** i - 1
        y.append(m & temp)
        m = m >> i
    indexes = [1, 4, 2, 0, 3, 5]
    indexes.reverse()
    res = 0
    c = 0
    for i in indexes:
        y[i] = y[i] << c
        res += y[i]
        c += arr[i]
    return res

print(main('0x1280766daae'))