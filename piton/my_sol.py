''' 10
def main(inp):
    inp = [' '.join(i) for i in inp]

    inp = list(dict.fromkeys(inp))

    res = [i.split() for i in inp]

    res = [[i[1], i[2].ljust(6, '0'), i[3].split('@')[1]] for i in res]
    res = [[*i] for i in list(zip(*res))]
    return res

'''

''' 9
def main(s):
    dct = dict()

    s = s.replace("\n", " ")
    s = s.replace("<:", "").replace(":>", "").replace("do var ", "")
    s = s.replace("array(", "").replace(")", "")
    s = s.split("end")
    s = [i.split(":=") for i in s]

    for i in s:
        if(len(i) == 2):
            dct[i[0].strip()] = list(map(int, i[1].strip().split(',')))
    return dct
'''

''' 8 
def main(n):
    m = int(n, 16)
    y = []
    arr = [9, 10, 9, 4, 7, 3]
    arr.reverse()
    for i in arr:
        temp = int('0b'+'1' * i, 2)
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
'''

''' 7
def main(x):
    match x[0]:
        case 2011:
            return 14
        case 1976:
            return f1(x)
        case 1999:
            return f2(x)


def f1(x):
    match x[4]:
        case 'PIC':
            return PIC(x)
        case 'COBOL':
            return 13


def PIC(x):
    match x[2]:
        case 'STON':
            return 8
        case 'HAXE':
            return 12
        case 'XS':
            return XS(x)


def XS(x):
    match x[1]:
        case 1998:
            return 9
        case 1994:
            return 10
        case 1981:
            11


def f2(x):
    match x[2]:
        case 'XS':
            return 6
        case 'HAXE':
            return 7
        case 'STON':
            return STON(x)


def STON(x):
    match x[4]:
        case 'PIC':
            return PIC_2(x)
        case 'COBOL':
            return COBOL(x)


def PIC_2(x):
    match x[1]:
        case 1998:
            return 0
        case 1994:
            return 1
        case 1981:
            return 2


def COBOL(x):
    match x[1]:
        case 1998:
            return 3
        case 1994:
            return 4
        case 1981:
            return 5

'''

''' 6
from math import *


def main(z):

    # o = set()
    # for i in range(-21, 70):
    #     if i in z:
    #         o.add(4 * i + 9 * i)
    # b = set()
    # for i in range(-35, 56):
    #     if i in z:
    #         b.add(abs(i) + i % 3)
    o = {4 * x + 9 * x for x in z if -22 < x < 70}
    b = {abs(x) + x % 3 for x in z if -36 < x < 56}

    Ivar = o.union(b)

    a = set()

    # for i in o:
    #     if i < -36 or i >= 17:
    #         a.add(i)
    a = {x for x in o if 17 <= x or x < -36}

    return sum(Ivar) + 8 * sum(a)
'''