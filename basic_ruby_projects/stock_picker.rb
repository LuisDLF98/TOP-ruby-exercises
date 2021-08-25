def stock_picker(price_list)
   max_profit = 0 
   indexes = Array.new(2)

   price_list.each_index do |i|
    price_list.each_index do |j|
        if i < j && price_list[j].to_i - price_list[i].to_i > max_profit
            max_profit = price_list[j].to_i - price_list[i].to_i
            indexes[0] = i
            indexes[1] = j
        end
    end  
   end

   indexes
end

# input = [17,3,6,9,15,8,6,1,10]

puts "Enter a list of positive integers, separated only by spaces"
input = gets.chomp

# Unless the user inputs a positive integer list, the program will continue to ask for one
until /^\d+(\s+\d+)*$/.match(input)
    puts "Enter a list of positive integers, separated only by spaces"
    input = gets.chomp
end

input_list = input.split(" ")

p stock_picker(input_list)