import pandas as pd

path = "Book1.xlsx"

df = pd.read_excel(path, sheet_name="Sheet3")

output = []

arr = df.values

print(arr)

for row in arr:
    print(row)
    for i in range(1, len(row)):
        b = bin(i - 1)[2:].rjust(3, '0')
        output.append(f"{{{row[0]}_0, 3'b{b}}}, {{{row[0]}_1, 3'b{b}}}: new_state = {row[i][:-2]}_{row[i][-1]}")


print(*output, sep="\n")

with open('output.txt', 'w') as file:
    for i in range(4):
        file.write(f"S{i}_0=3'b{bin(i)[2:].rjust(2, '0')}0, S{i}_1=3'b{bin(i)[2:].rjust(2, '0')}1,\n")
    file.write("\n")
    for i in output:
        file.write(i + ";\n")