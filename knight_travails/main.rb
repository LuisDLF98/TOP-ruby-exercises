require_relative "tree"

tree = Knight_Tree.new
tree.build_tree([3,3])

moves = tree.knight_moves([3,3],[4,3])

puts "You made it in #{moves.size} moves! Here's your path:"
moves.each do |move|
    puts "\t#{move}"
end