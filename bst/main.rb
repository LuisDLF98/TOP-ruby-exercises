require_relative "tree"

tree = Tree.new
array = [1,5,4,8,0,6]
tree.build_tree(array, 0, array.length)
tree.print