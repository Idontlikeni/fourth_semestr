from math import *


def main(B):

    A = set()
    Phi = set()
    N = set()

    A = {ceil(b/4) - b for b in B if b > -96 and b <= 59}
    Phi = {b - floor(b/8) for b in B if b > -38}
    N = {lam + ceil(p/6) for lam in A for p in Phi if lam > p}

    res = len(Phi.union(N)) + sum([p % 3 + v for p in Phi for v in N])
    return res
