$LOAD_PATH << __dir__ # delete this eventually

require 'node'

class List
  attr_accessor :head

  def initialize(head=nil)
    @head = head
  end

  def append(new_node)
    self.head = new_node if self.head.nil?
    current_node = head
    loop do
      if current_node.next_node.nil?
        current_node.next_node = new_node
        break
      else
        current_node = current_node.next_node
      end
    end
  end

  def prepend(new_node)
    new_node.next_node = self.head
    self.head = new_node
  end

  def includes?(data)
    current_node = head
    loop do
      return true if current_node.data == data
      return false if current_node.next_node.nil?
      current_node = current_node.next_node
    end
  end

  def pop
    return if self.head.nil?
    current_node = head
    if current_node.next_node.nil?
      self.head = nil
      return current_node
    else
      previous_node = current_node
      next_node = current_node.next_node
    end

    while current_node.next_node
      previous_node = current_node
      current_node = current_node.next_node
    end

    previous_node.next_node = nil
    current_node
  end

  def count
    return 0 if self.head.nil?
    return 1 if self.head.next_node.nil?

    count = 1
    current_node = head

    while current_node.next_node
      current_node = current_node.next_node
      count += 1
    end
    count
  end

  def tail
    return if self.head.nil?
    current_node = head
    while current_node.next_node
      current_node = current_node.next_node
    end
    current_node
  end

  def find_by_index(index)
    return if self.head.nil?
    return self.head if index == 0
    current_node = head
    index.times do
      if current_node.next_node
        current_node = current_node.next_node
      else
        return
      end
    end
    current_node
  end

  def find_by_value(value)
    return if self.head.nil?
    current_node = head

    if current_node.data == value
      return current_node
    end

    # add a next_node variable?
    while current_node.next_node
      if current_node.data == value
        return current_node
      elsif current_node.next_node.data == value
        return current_node.next_node
      else
        current_node = current_node.next_node
      end
    end
  end

end

# Linked List
node_b = Node.new('b')
node_a = Node.new('a', node_b)
list = List.new(node_a)

node_b
list.find_by_value('b')
