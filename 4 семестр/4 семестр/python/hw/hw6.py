from math import floor


def main(a):
    sig = {d for d in a if -13 <= d <= 36}
    n = {x ** 2 for x in a if -59 < x < 0}
    a_1 = {w ** 3 for w in a if w >= 66}
    o = n | a_1
    return len(a_1 | o) - sum(((floor(lym / 7))
                               + 5 * o_1) for lym in a_1 for o_1 in o)


print(main({96, -29, -60, 38, -81, 48, -78, -45, 54}))
