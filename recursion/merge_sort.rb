# Helper method for merge_sort.
# Merges 2 subarrays back into array
def merge(array, left, middle, right)
    sub_left = middle - left + 1
    sub_right = right - middle

    # Create left and right subarrays.
    left_array = array[left..middle]
    right_array = array[(middle + 1)..right]

    index_left_array = 0
    index_right_array = 0
    index_merged_array = left

    # Merge both subarrays back into array.
    while index_left_array <  sub_left && index_right_array < sub_right do
        if left_array[index_left_array] <= right_array[index_right_array]
            array[index_merged_array] = left_array[index_left_array]
            index_left_array += 1
        else
            array[index_merged_array] = right_array[index_right_array]
            index_right_array += 1
        end

        index_merged_array += 1
    end

    # Merge the remaining values in left_array, if there are any.
    while index_left_array < sub_left do
        array[index_merged_array] = left_array[index_left_array]
        index_left_array += 1
        index_merged_array += 1
    end

    # Merge the remaining values in right_array, if there are any.
    while index_right_array < sub_right do
        array[index_merged_array] = right_array[index_right_array]
        index_right_array += 1
        index_merged_array += 1
    end
end

# Sorting method that breaks the array into smaller subarrays and merges them
# back in as it sorts the subarrays.
def merge_sort(array, left, right)
    if right - left <= 0
        return
    end

    middle = left + (right - left) / 2

    # Break out into subarrays
    merge_sort(array, left, middle)
    merge_sort(array, middle + 1, right)

    # Merge the arrays
    merge(array, left, middle, right)

    array
end

list = [1,9,2,6,4,7,10,3,5,0]
p merge_sort(list, 0, list.length - 1)