def main(n):
    m = int(n)
    y = []
    arr = [4, 1, 3, 6]
    arr.reverse()
    for i in arr:
        temp = int('0b'+'1' * i, 2)
        y.append(m & temp)
        m = m >> i
    indexes = [1, 2, 3, 0]
    indexes.reverse()
    res = 0
    c = 0
    for i in indexes:
        y[i] = y[i] << c
        res += y[i]
        c += arr[i]
    return hex(res)

print(main('10936'))