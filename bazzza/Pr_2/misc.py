import csv
lines = []
with open("input.txt", 'r', encoding='utf-8') as f:
    # Read all lines from the .txt file
    lines = f.readlines()
print(lines)

form = [1, 2]

with open('output6.csv', 'w', newline='') as csvfile: # потом убрать энкодинг, а то в экселе не будет робить
    writer = csv.writer(csvfile, delimiter=';')
    for line in lines[1:]:
        arr = line.replace("\n", "").split()

        res = []
        
        c = 0
        for i in form:
            temp = []
            for j in range(i):
                temp.append(arr[c])
                c += 1
            res.append(' '.join(temp))
        print(res)
        # print(arr)
        writer.writerow(res)