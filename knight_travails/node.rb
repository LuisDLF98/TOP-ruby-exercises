class Node
    include Comparable
    attr_accessor :value, :children, :parent

    def initialize(value = nil, children = [], parent = nil)
        @value = value
        @children = children
        @parent = parent
    end

    def <=>(other_node)
        @value <=> other_node.value
    end
end