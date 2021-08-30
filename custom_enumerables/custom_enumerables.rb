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

    def my_map(*args)
        array = []

        case args.size
        when 0
            for i in (0...self.length) do 
                array.push(yield(self[i]))
            end

        when 1
            for i in (0...self.length) do 
                array.push(args[0].call(self[i]))
            end
        end

        array
    end

    def my_inject(result = 0)
        for i in (0...self.length) do 
            result = yield(result, self[i])
        end

        result
    end
end


def multiply_els(array)
    array.my_inject(1) { |product, number|
        product = product * number
        product
    }
end


numbers = [1, 2, 3, 4, 5]

puts "my_each vs. each"
numbers.my_each { |item| puts item }
numbers.each { |item| puts item }

puts "my_each_with_index vs. each_with_index"
numbers.my_each_with_index { |item, index| puts "numbers[#{index}] = #{item}" }
numbers.each_with_index { |item, index| puts "numbers[#{index}] = #{item}" }

puts "my_select vs. select"
p numbers.my_select { |item| item < 4 }
p numbers.select { |item| item < 4 }

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

puts "my_map (proc) vs. my_map vs. map"
p numbers.my_map(Proc.new { |item| item += 1 })
p numbers.my_map { |item| item += 1 }
p numbers.map { |item| item += 1 }

puts "my_inject vs. inject"
puts numbers.my_inject { |sum, number|
    sum += number
    sum
}
puts numbers.reduce { |sum, number|
    sum += number
    sum
}
p numbers.my_inject(Hash.new(0)) { |sum, number|
    sum[number] = number ** 2
    sum
}
p numbers.inject(Hash.new(0)) { |sum, number|
    sum[number] = number ** 2
    sum
}
puts "multiply_els result: #{multiply_els([2,4,5])}"