module Enumerable
    def my_each
        for i in (0...self.length) do 
            yield(self[i])
        end
    end

    def my_each_with_index
        for i in (0...self.length) do 
            yield(self[i], i)
        end
    end
end



numbers = [1, 2, 3, 4, 5]

puts "my_each vs. each"
numbers.my_each { |item| puts item }
numbers.each { |item| puts item }

puts "my_each_with_index vs. each_with_index"
numbers.my_each_with_index { |item, index| puts "numbers[#{index}] = #{item}" }
numbers.each_with_index { |item, index| puts "numbers[#{index}] = #{item}" }