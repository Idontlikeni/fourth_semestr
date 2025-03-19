def print_array(arr):
    for a in arr:
        print(a, end=' ')
    print("\n")


def subsort(arr, n):
    nums = [0 for _ in range(10)]
    sorted_arr  = [0 for _ in range(n)]
    counter = 0
    for i in arr:
        nums[i]+=1

    for i in range(10):
        for _ in range(nums[i]):
            sorted_arr[counter] = i
            counter += 1
    
    return sorted_arr

print(subsort([4, 7, 3, 2, 5, 6, 3, 1], 8))