def main(inp):
    inp = [i[1:] for i in inp]
    ans = [' '.join(i).replace('[at]', '@') for i in inp]
    ans = [i.split(';') for i in ans]
    ans = [i[0].split(" ") + [i[1]] for i in ans]
    ans = sorted(ans, key=lambda x: x[3])
    ans = [[*i] for i in list(zip(*ans))]
    ans[1] = list(map(lambda x: '-'.join([x[-2:], x[3: 5], x[:2]]), ans[1]))
    ans[3] = list(map(lambda x:
                      x.replace(' ', '(', 1)
                      .replace(' ', ')', 1), ans[3]))
    ans[3] = list(map(lambda x: x[:13] + '-' + x[13:], ans[3]))
    ans[2] = list(map(lambda x: 'Да' if x == '1' else 'Нет', ans[2]))
    ans[3], ans[2] = ans[2], ans[3]
    return ans
