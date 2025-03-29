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
