def merge(arr, left, mid, right):
    it1 = 0
    it2 = 0

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
    
    if flag: it1 += 1
    
    flag = False

    for i in range(it2, right - mid):
        result[it1 + i] = arr[mid + i]
        it2 = i
        flag = True

    if flag: it2 += 1

    for i in range(it1 + it2):
        arr[left + i] = result[i]
    return result

def mergeSortIterative(a):
    if len(a) == 0: 
        return -1
    i = 1
    n = len(a)
    while i < n:
        for j in range(0, n-i, 2 * i):
            merge(a, j, j + i, min(j + 2 * i, n))
        i *= 2
    return 0

n = 3
arr = [7, 3, 1]

print("n: =", n, "| arr:", [7, 3, 1], "| sorted:", arr, "| error code: ", mergeSortIterative(arr))
n = 5
arr = [7, 3, 1, 2]
print("n: =", n, "| arr:", [7, 3, 1, 2], "| sorted:", arr, "| error code: ", mergeSortIterative(arr))
n = 0
arr = []
print("n: =", n, "| arr:", [], "| sorted:", arr, "| error code: ", mergeSortIterative(arr))