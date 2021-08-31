require_relative "tree"

tree = Tree.new
array = [1,5,4,8,0,6]
tree.build_tree(array, 0, array.length)
tree.print

tree.insert(9)
tree.insert(2)
tree.print

tree.delete(5)
tree.print

p tree.find(4)

# Tree traversals
puts "Level Order: #{tree.level_order}"
puts "Inorder: #{tree.in_order}"
puts "Postorder: #{tree.post_order}"
puts "Preorder: #{tree.pre_order}"

p tree.height(tree.find(1))
p tree.depth(tree.find(2))

puts "Tree before rebalance:"
tree.print
puts "Tree after rebalance:"
tree.rebalance
tree.print