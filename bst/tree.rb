require_relative "node"

class Tree
    def initialize
        @root = nil
    end

    # Builds the tree from a given array.
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

    # Adds a value to the tree.
    def insert(value, node = @root)
        if node.nil?
            return Node.new(value)
        end

        if value > node.value
            node.right_node = insert(value, node.right_node)
        elsif value < node.value
            node.left_node = insert(value, node.left_node)
        end

        return node
    end

    # Finds the child with the lowest value.
    def min_node(node)
        current = node

        if current.nil?
            return current
        end

        until current.left_node.nil?
            current = current.left_node
        end

        return current
    end

    # Deletes the specified value from the tree.
    def delete(value, node = @root)
        if node.nil?
            return node 
        end

        if value < node.value
            node.left_node = delete(value, node.left_node)
        elsif value > node.value
            node.right_node = delete(value, node.right_node)
        else
            if  node.left_node.nil? && node.right_node.nil?
                return nil
            elsif node.left_node.nil?
                return node.right_node
            elsif node.right_node.nil?
                return node.left_node
            end

            # Switches the current node's value with the child with the lowest value greater than
            # the current node, then delete the child.
            temp = min_node(node.right_node)
            node.value = temp.value
            node.right_node = delete(temp.value, node.right_node)
        end

        return node
    end

    # Return the node containing the given value.
    def find(value, node = @root)
        if node.nil?
            return nil
        end

        if value < node.value
            return find(value, node.left_node)
        elsif value > node.value
            return find(value, node.right_node)
        else
            return node
        end
    end

    # Returns a list of the tree's values ordered in the order that they
    # were explored during a BFS.
    def level_order
        explored =  []
        queue = Queue.new
        explored.push(@root.value)
        queue << @root

        until queue.empty? do
            temp = queue.pop

            unless temp.left_node.nil? || explored.include?(temp.left_node.value)
                explored.push(temp.left_node.value)
                queue << temp.left_node
            end

            unless temp.right_node.nil? || explored.include?(temp.right_node.value)
                explored.push(temp.right_node.value)
                queue << temp.right_node
            end
        end

        return explored
    end

    # Inorder DFS (Searches [left][root][right]) that returns an array
    # ordered in the order that the values were explored during the DFS.
    def in_order(node = @root, explored = [])
        unless node.left_node.nil?
            in_order(node.left_node, explored)
        end

        explored.push(node.value)

        unless node.right_node.nil?
            in_order(node.right_node, explored)
        end

        return explored
    end

    # Postorder DFS (Searches [left][right][root]) that returns an array
    # ordered in the order that the values were explored during the DFS.
    def post_order(node = @root, explored = [])
        unless node.left_node.nil?
            post_order(node.left_node, explored)
        end

        unless node.right_node.nil?
            post_order(node.right_node, explored)
        end

        explored.push(node.value)

        return explored
    end

    # Preorder DFS (Searches [root][left][right]) that returns an array
    # ordered in the order that the values were explored during the DFS.
    def pre_order(node = @root, explored = [])
        explored.push(node.value)

        unless node.left_node.nil?
            post_order(node.left_node, explored)
        end

        unless node.right_node.nil?
            post_order(node.right_node, explored)
        end

        return explored
    end

    # Returns the longest number of edges from one node to a leaf
    def height(node, count = 0)
        if node.nil?
            return count - 1 # Subtract 1 because the current method counts the number of nodes, not edges.
        end
        
        count += 1
        count = [height(node.left_node, count), height(node.right_node, count)].max

        return count
    end

    # Returns the number of edges between the given node and the tree's root node
    def depth(node, current = @root, count = 0)
        if current.eql?(node)
            return count
        elsif current.nil?
            return 0
        else
            count += 1
            count = [depth(node, current.left_node, count), depth(node, current.right_node, count)].max
            return count
        end
    end

    # Rebuilds the tree using build_tree()
    def rebalance
        order = self.level_order
        return build_tree(order, 0, order.length)
    end

    # Checks if the tree is balanced.
    # The tree is balanced if the height from the root's left and right
    # children have a difference of no greater than 1.
    def balanced?
        left = height(@root.left_node)
        right = height(@root.right_node)

        if (left - right).abs <= 1
            return true
        end

        return false
    end

    # Print method given from The Odin Project to visualize the tree
    def print(node = @root, prefix = '', is_left = true)
        if node.nil?
            return
        end

        print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
      end
end