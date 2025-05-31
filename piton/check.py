def trace(x, y):
    tr = str.maketrans({'[': '(', ']': ')'})
    for (op, *args), o in zip(x, y[:-1]):
        call = f'obj.{op}{args} # {repr(o)}'
        yield call.translate(tr)

# Получено:
y = [None, ('exception', 'MachineException', 'unkown'), '<<< Ошибка!']

# Входные данные: 
x = (('let_y', 1), ('build',), ('has_path_to', 'v5'), ('chain',), ('let_r', 1), ('has_path_to', 'v0'), ('boost',), ('get_output',), ('boost',), ('let_y', 0), ('seen_method', 'boost'), ('get_output',), ('init',), ('get_output',), ('has_path_to', 'v5'), ('boost',), ('get_output',), ('sit',), ('patch',), ('patch',), ('get_output',), ('cut',), ('tag',), ('get_output',), ('tag',), ('has_path_to', 'v1'), ('erase',), ('init',), ('seen_method', 'init'), ('get_output',), ('chain',), ('patch',), ('has_path_to', 'v1'), ('seen_method', 'boost'), ('get_output',), ('seen_method', 'patch'), ('boost',), ('get_output',), ('init',), ('get_output',))


# Генерация трассы:
print('\n'.join(trace(x, y)))