# Shift each letter of a string by some factor
# 'z' wraps back to 'a'
def caesar_cipher(string, factor)
    ind = 0

    string.each_char do |char|
        if ("a".."z").include?(char.downcase)
            factor.times { char = char.next }
        end
        string[ind] = char[-1]
        ind += 1
    end

    string
end

puts "Type in a string to encrypt:"
text_input = gets.chomp

puts "Type in a shift factor (integer)"
int_input = gets.chomp

# Unless the user inputs a positive integer, the program will continue to ask for one
until /\A[+]?\d+\z/.match(int_input)
    puts "Type in a shift factor (integer)"
    int_input = gets.chomp
end

puts caesar_cipher(text_input, int_input.to_i)