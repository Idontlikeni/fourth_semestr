def merge(arr, left, mid, right):
    it1 = 0
    it2 = 0

    # print("lmr", left, mid, right)

    result = [0 for _ in range(right - left)]

    while left + it1 < mid and mid + it2 < right:
        if arr[left + it1] < arr[mid + it2]:
            result[it1 + it2] = arr[left + it1]
            it1 += 1
        else:
            result[it1 + it2] = arr[mid + it2]
            it2 += 1

    flag = False

    for i in range(it1, mid - left):
        result[i + it2] = arr[left + i]
        it1 = i
        flag = True
        # print(it1)
    
    if flag: it1 += 1
    
    flag = False

    for i in range(it2, right - mid):
        result[it1 + i] = arr[mid + i]
        it2 = i
        # print(it2)
        flag = True

    if flag: it2 += 1
    # while left + it1 < mid:
    #     result[it1 + it2] = arr[left + it1]
    #     it1 += 1
    
    # while mid + it2 < right:
    #     result[it1 + it2] = arr[mid + it2]
    #     it2 += 1

    # print("its: ", it1, it2)
    for i in range(it1 + it2):
        arr[left + i] = result[i]
    return result

def mergeSortIterative(a):
    if len(a) > 4: 
        return [-1]
    i = 1
    n = len(a)
    while i < n:
        for j in range(0, n-i, 2 * i):
            merge(a, j, j + i, min(j + 2 * i, n))
            #print(i, j)
        i *= 2
n = 3
arr = [7, 3, 1]

print(mergeSortIterative(arr), arr)

n = 4
arr = [7, 3, 1, 2]

print(mergeSortIterative(arr), arr)

n = 5
arr = [1, 2, 7, 4, 2]

print(mergeSortIterative(arr), arr)