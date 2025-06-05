def trace(x, y):
    tr = str.maketrans({'[': '(', ']': ')'})
    for (op, *args), o in zip(x, y[:-1]):
        call = f'obj.{op}{args} # {repr(o)}'
        yield call.translate(tr)

# Получено:
y = [False, 0, None, 0, None, 'J4', 'J1', 'J3', 'J4', True, None, ('exception', 'MachineError', 'unsupported'), 0, False, True, 'J2', 'J0', ('exception', 'MachineError', 'unknown')]

# Входные данные: 
x = (('seen_method', 'scale'), ('seen_edge', 'D4', 'D2'), ('z', 0), ('seen_edge', 'D5', 'D6'), ('e', 1), ('move', 'get'), ('move', 'get'), ('move', 'crack'), ('move', 'paint'), ('seen_method', 'crack'), ('e', 0), ('move', 'crack'), ('seen_edge', 'D4', 'D2'), ('seen_method', 'scale'), ('has_max_in_edges',), ('move', 'paint'), ('move', 'scale'), ('move', 'amble'))

# Генерация трассы:
print('\n'.join(trace(x, y)))
