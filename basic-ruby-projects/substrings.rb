# Returns a hash listing each substring that was found in the orginal word and 
# counts how many times is was found
def substrings(word, substring_list)
    substring_list.reduce(Hash.new(0)) do |result, substring|
        result[substring] += word.scan(/(?=#{substring})/).count if word.include?(substring)
        result
    end
end

puts "Enter a word:"
text_input = gets.chomp.downcase

puts "Enter a list of substrings (separated only by spaces)"
list_input = gets.chomp.downcase

list = list_input.split(" ")

puts substrings(text_input, list)