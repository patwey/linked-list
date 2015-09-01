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
end

# Linked List


linked_list = List.new
node_a = Node.new('a')
node_b = Node.new('b')

linked_list.append(node_a)
linked_list.head
linked_list
