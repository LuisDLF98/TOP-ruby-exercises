class Node
    attr_accessor :value, :next_node

    def initialize(data = nil, node = nil)
        @value = data
        @next_node = node
    end
end