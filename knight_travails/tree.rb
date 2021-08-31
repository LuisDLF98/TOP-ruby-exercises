require_relative "node"

class Knight_Tree
    attr_accessor :root

    def initialize
        @root = nil
    end

    # Returns true if other_node is an ancestor of child
    def is_ancestor?(child, other_node)
        temp = child.parent

        until temp.nil? do
            if temp == other_node
                return true
            end

            temp = temp.parent
        end

        return false
    end

    # Returns true if the position is outside the 8x8 chessboard
    def is_out?(position)
        unless (0..7).include?(position[0]) && (0..7).include?(position[1])
            return true
        end

        return false
    end

    # Returns an unfiltered list of possible moves the knight can take
    def find_possible_children(position)
        children = []
        children << Node.new([position.value[0] + 2, position.value[1] + 1])
        children << Node.new([position.value[0] + 2, position.value[1] - 1])
        children << Node.new([position.value[0] - 2, position.value[1] + 1])
        children << Node.new([position.value[0] - 2, position.value[1] - 1])

        children << Node.new([position.value[0] + 1, position.value[1] + 2])
        children << Node.new([position.value[0] + 1, position.value[1] - 2])
        children << Node.new([position.value[0] - 1, position.value[1] + 2])
        children << Node.new([position.value[0] - 1, position.value[1] - 2])
        
        # Filter out unwanted nodes
        children.reject! { |child| is_out?(child.value) || is_ancestor?(position, child) }

        return children
    end

    # Build a new tree with star_position as the root
    def build_tree(start_position)
        @root = Node.new(start_position)
        build_driver(@root)
    end

    def build_driver(node, count = 0)
        # Limit the depth of the tree.
        # This means the tree can't find that take more than 5 moves.
        if count >= 5
            return
        end

        children = find_possible_children(node)

        unless children.empty?
            node.children = children

            node.children.each do |child|
                child.parent = node
                build_driver(child, count + 1)
            end
        end
    end

    # Finds the number moves it takes to move from one position to another
    # using BFS.
    def knight_moves(start_position, end_position)
        explored =  []
        queue = Queue.new
        explored.push(@root.value)
        queue << @root

        until queue.empty? do
            temp = queue.pop

            if end_position.eql?(temp.value)
                curr = temp
                result = []

                # Go up the tree and build the path
                until curr.nil?
                    result.push(curr.value)
                    curr = curr.parent
                end

                return result.reverse
            end

            # Add children to the queue
            temp.children.each do |child|
                unless child.nil? || explored.include?(child.value)
                    explored.push(child.value)
                    queue << child
                end
            end
        end

        return explored
    end
end