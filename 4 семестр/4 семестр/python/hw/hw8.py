def main(bit_fields):
    bit_positions = {'K1': [0, 6],
                     'K2': [7, 9],
                     'K3': [10, 16],
                     'K4': [17, 26]}

    result = 0

    for i, value_hex in enumerate(bit_fields):
        value = int(value_hex, 16)
        field = 'K' + str(i + 1)
        start, end = bit_positions[field]
        result |= value << start

    return str(hex(result))

# def main(bit_fields):
#     bit_positions = {'K1': [0, 6],
#                      'K2': [7, 9],
#                      'K3': [10, 16],
#                      'K4': [17, 26]}
#
#     result = 0
#
#     for field, value in bit_fields.items():
#         start, end = bit_positions[field]
#         result |= value << start
#
#     return hex(result)
