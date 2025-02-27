import csv
lines = []
with open("input.txt", 'r', encoding='utf-8') as f:
    # Read all lines from the .txt file
    lines = f.readlines()
print(lines)

form = [1, 1]

with open('output.csv', 'w', newline='', encoding='utf-8') as csvfile: # потом убрать энкодинг, а то в экселе не будет робить
    writer = csv.writer(csvfile, delimiter=';')
    for line in lines[1:]:
        arr = line.replace("\n", "").split()

        writer.writerow([line[0], line[2:].replace("\n", "")])