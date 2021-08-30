require_relative "node"

class Linkedlist
    attr_accessor :head, :tail

    def initialize(value = nil)
        unless value.nil?
            @head = Node.new(value)
            @tail = @head
        else
            @head = nil
            @tail = nil
        end

    end

    # Add a node to the end of the list
    def append(value)
        if @head.nil?
            @head = Node.new(value)
            @tail = @head
        else
            temp = Node.new(value)
            @tail.next_node = temp
            @tail = temp
        end
    end

    # Add a node to the start of the list
    def prepend(value)
        if @head.nil?
            @head = Node.new(value)
            @tail = @head
        else
            temp = Node.new(value)
            temp.next_node = @head
            @head = temp
        end
    end

    # Returns the size of the list
    def size
        temp = @head
        count = 0

        until temp.nil? do
            count += 1
            temp = temp.next_node
        end

        count
    end

    def at(index)
        temp = @head

        index.times do
            temp = temp.next_node
        end

        temp
    end

    # Removes the last node from the list
    def pop
        temp = @head

        until temp.next_node.eql?(@tail) do
            temp = temp.next_node
        end

        temp.next_node = nil
        @tail = temp
    end

    # Check if the given value is contained within the list
    def contains?(value)
        temp = @head

        until temp.nil? do
            if temp.value == value
                return true
            end

            temp = temp.next_node
        end

        false
    end

    # Returns the index of the node containing the value
    # Returns nil if the value can not be found
    def find(value)
        temp = @head
        count = 0

        until temp.nil? do
            if temp.value == value
                return count
            end

            count += 1
            temp = temp.next_node
        end

        nil
    end

    # Converts the list into a string
    def to_s
        temp = @head
        string = ""

        until temp.nil? do
            string << "( #{temp.value} ) -> "
            temp = temp.next_node
        end

        string << "nil"
    end

    # Insert value at the specified index
    # If the insertion was successful return 0, otherwise return nil
    def insert_at(value, index)
        temp = @head
        count = 0

        if index == 0
            self.prepend(value)
            return 0
        end

        until temp.nil? do
            if count == index - 1
                new_node = Node.new(value)
                new_node.next_node = temp.next_node
                temp.next_node = new_node
                return 0
            end

            count += 1
            temp = temp.next_node
        end

        return nil
    end

    # Removes value at the specified index
    # If the deletion was successful return 0, otherwise return nil
    def remove_at(index)
        temp = @head
        count = 0

        if index == 0
            temp = @head.next_node
            @head.next_node = nil
            @head = temp
            return 0
        end

        until temp.next_node.nil? do
            if count == index - 1
                temp2 = temp.next_node
                temp.next_node = temp2.next_node
                temp2.next_node = nil
                return 0
            end

            count += 1
            temp = temp.next_node
        end

        return nil
    end
end