module Enumerable
    def my_each
        for i in (0...self.length) do 
            yield(self[i])
        end
    end
end



puts "my_each vs. each"
numbers = [1, 2, 3, 4, 5]
numbers.my_each { |item| puts item }
numbers.each { |item| puts item }