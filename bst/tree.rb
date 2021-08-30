require_relative "node"

class Tree
    def initialize
        @root = nil
    end

    def build_tree(array, left, right)
        array.sort!.uniq!

        if right - left <= 0
            return 
        end

        middle = left + (right - left) / 2
        root = Node.new(array[middle])

        root.left_node = build_tree(array, left, middle)
        root.right_node = build_tree(array, middle + 1, right)

        @root = root
        return root
    end

    def print(node = @root, prefix = '', is_left = true)
        if node.nil?
            return
        end

        print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
      end
end