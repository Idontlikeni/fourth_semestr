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

    while left + it1 < mid:
        result[it1 + it2] = arr[left + it1]
        it1 += 1
    
    while mid + it2 < right:
        result[it1 + it2] = arr[mid + it2]
        it2 += 1
    
    for i in range(it1 + it2):
        arr[left + i] = result[i]
    return result

def mergeSortIterative(a):
    i = 1
    n = len(a)
    while i < n:
        for j in range(0, n-i, 2 * i):
            merge(a, j, j + i, min(j + 2 * i, n))
        i *= 2

arr = [12, 5, 32, 6, 1, 4, 63, 2]

# print(mergeSortIterative(arr))

# merge(arr, 0, 4, len(arr))
print(mergeSortIterative(arr), arr)