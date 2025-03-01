from math import ceil


def main(y):
    conditions = {
        y < 87: lambda y: (y - 79 * (y ** 4) - 72 * (ceil(y) ** 7)),
        y >= 87 and y < 160: lambda y: ((59 * y + 89 + 19
                                         * (y ** 2)) ** 7),
        y >= 160: lambda y: (88 * (y ** 3 + y ** 2 + 87) ** 6),
    }
    for condition, result in conditions.items():
        if condition:
            return result(y)


print(result(57))

# def main(y):
#     while y < 87:
#         return y - 79 * (y ** 4) - 72 * (ceil(y) ** 7)
#     while y >= 87 and y < 160:
#         return (59 * y + 89 + 19 * (y ** 2)) ** 7
#     while y >= 160:
#         return 88 * (y ** 3 + y ** 2 + 87) ** 6
