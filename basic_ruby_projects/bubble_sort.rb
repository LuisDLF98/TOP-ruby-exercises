# Sorts a list by swapping 2 numbers if the number at the lower index
# is greater then the one at the higher index. 
def bubble_sort(list)

    loop do
        count = 0

        # Go through the list and swap values if needed
        list.each_index do |idx|
            if idx + 1 < list.length && list[idx] > list[idx + 1]
                count += 1
                temp = list[idx + 1]
                list[idx + 1] = list[idx]
                list[idx] = temp
            end
        end

        # Loop until there no more values to swap (list is sorted)
        break if count == 0
    end

    list
end

puts "Enter a list of positive integers, separated only by spaces"
input = gets.chomp

# Unless the user inputs a positive integer list, the program will continue to ask for one
until /^\d+(\s+\d+)*$/.match(input)
    puts "Enter a list of positive integers, separated only by spaces"
    input = gets.chomp
end

input_list = input.split(" ").map(&:to_i)

p bubble_sort(input_list)