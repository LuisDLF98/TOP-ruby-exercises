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

    def my_select
        array = []

        for i in (0...self.length) do 
            if yield(self[i])
                array.push(self[i])
            end
        end

        array
    end

    def my_all?
        for i in (0...self.length) do 
            unless yield(self[i])
                return false
            end
        end

        true
    end

    def my_any?
        for i in (0...self.length) do 
            if yield(self[i])
                return true
            end
        end

        false
    end

    def my_none?
        for i in (0...self.length) do 
            if yield(self[i])
                return false
            end
        end

        true
    end

    def my_count
        count = 0

        for i in (0...self.length) do 
            if yield(self[i])
                count += 1
            end
        end

        count
    end

    def my_map
        array = []

        for i in (0...self.length) do 
            array.push(yield(self[i]))
        end

        array
    end
end



numbers = [1, 2, 3, 4, 5]

puts "my_each vs. each"
numbers.my_each { |item| puts item }
numbers.each { |item| puts item }

puts "my_each_with_index vs. each_with_index"
numbers.my_each_with_index { |item, index| puts "numbers[#{index}] = #{item}" }
numbers.each_with_index { |item, index| puts "numbers[#{index}] = #{item}" }

puts "my_select vs. select"
puts numbers.my_select { |item| item < 4 }
puts numbers.select { |item| item < 4 }

puts "my_all? vs. all?"
puts numbers.my_all? { |item| item < 4 }
puts numbers.all? { |item| item < 4 }
puts numbers.my_all? { |item| item < 6 }
puts numbers.all? { |item| item < 6 }

puts "my_any? vs. any?"
puts numbers.my_any? { |item| item < 4 }
puts numbers.any? { |item| item < 4 }
puts numbers.my_any? { |item| item > 6 }
puts numbers.any? { |item| item > 6 }

puts "my_none? vs. none?"
puts numbers.my_none? { |item| item < 4 }
puts numbers.none? { |item| item < 4 }
puts numbers.my_none? { |item| item > 6 }
puts numbers.none? { |item| item > 6 }

puts "my_count vs. count"
puts numbers.my_count { |item| item < 4 }
puts numbers.count { |item| item < 4 }

puts "my_map vs. map"
puts numbers.my_map { |item| item += 1 }
puts numbers.map { |item| item += 1 }