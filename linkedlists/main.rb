require_relative "linkedlist"

my_list = Linkedlist.new(1)
my_list.prepend(5)
my_list.prepend(2)
my_list.append(4)
my_list.append(7)
my_list.append(8)
my_list.append(3)
my_list.append(6)

p my_list.size
p my_list.at(6)

# Check if pop works
my_list.pop
p my_list.at(my_list.size - 1)
p my_list.size

# Check if contains? works
p my_list.contains?(4)
p my_list.contains?(10)

p my_list.find(8)
p my_list.to_s

my_list.insert_at(14, 0)
p my_list.to_s
my_list.insert_at(15, 4)
p my_list.to_s
my_list.insert_at(65, my_list.size)
p my_list.to_s
my_list.insert_at(65, my_list.size + 1)
p my_list.to_s

my_list.remove_at(0)
p my_list.to_s
my_list.remove_at(4)
p my_list.to_s
my_list.remove_at(my_list.size - 1)
p my_list.to_s
my_list.remove_at(my_list.size)
p my_list.to_s