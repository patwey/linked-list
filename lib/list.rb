$LOAD_PATH << __dir__ # delete this eventually

require 'node'

class List
  attr_accessor :head

  def initialize(head=nil)
    @head = head
  end

  def includes?(data)
    node = head
    loop do
      return true if node.data = data
      next_node = node.next_node
      break if next_node.nil?
    end
  end
end

# Linked List
linked_list = List.new
node_a = Node.new('a')
node_b = Node.new('b')

linked_list.head = node_a
node_a.next_node = node_b

node_c = Node.new('c')
node_b.next_node = node_c
