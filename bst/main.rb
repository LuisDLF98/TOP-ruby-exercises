require_relative "tree"

# tree = Tree.new
# array = [1,5,4,8,0,6]
# tree.build_tree(array)

# puts "Original tree"
# tree.print

# puts "\nTree after calling insert:"
# tree.insert(9)
# tree.insert(2)
# tree.print

# puts "\nTree after calling delete:"
# tree.delete(5)
# tree.print

# puts "\nNode containing a value of 4:"
# p tree.find(4)
# puts "\n"

# # Tree traversals
# puts "Level Order: #{tree.level_order}"
# puts "Inorder: #{tree.in_order}"
# puts "Postorder: #{tree.post_order}"
# puts "Preorder: #{tree.pre_order}"

# puts "\nHeight at node value 1: #{tree.height(tree.find(1))}"
# puts "Depth of node value 2: #{tree.depth(tree.find(2))}\n"

# puts "\nTree before rebalance:"
# tree.insert(3)
# tree.print
# puts "Is the tree balanced?"
# puts "Answer: #{tree.balanced?}"

# puts "\nTree after rebalance:"
# tree.rebalance
# tree.print
# puts "Is the tree balanced?"
# puts "Answer: #{tree.balanced?}"



puts "Driver Script:"
new_tree = Tree.new
array = Array.new(15) {rand(1..100)}
new_tree.build_tree(array)

puts "Is the tree balanced?"
puts "Answer: #{new_tree.balanced?}"

# Tree traversals
puts "\nLevel Order: #{new_tree.level_order}"
puts "Inorder: #{new_tree.in_order}"
puts "Postorder: #{new_tree.post_order}"
puts "Preorder: #{new_tree.pre_order}"

puts "\nInserted new values"
(101..105).each do |number|
    new_tree.insert(number)
end

puts "\nIs the tree balanced?"
puts "Answer: #{new_tree.balanced?}"

puts "\nCalling rebalance..."
new_tree.rebalance

puts "\nIs the tree balanced?"
puts "Answer: #{new_tree.balanced?}"

# Tree traversals
puts "\nLevel Order: #{new_tree.level_order}"
puts "Inorder: #{new_tree.in_order}"
puts "Postorder: #{new_tree.post_order}"
puts "Preorder: #{new_tree.pre_order}"