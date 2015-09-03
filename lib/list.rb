$LOAD_PATH << __dir__ # delete this eventually

require 'node'

class List
  attr_accessor :head

  def initialize(head=nil)
    @head = head
  end

  def append(new_node)
    self.head = new_node if self.head.nil?
    tail.link = new_node
  end

  def prepend(new_node)
    new_node.link = self.head
    self.head = new_node
  end

  def remove_head(head_node)
    self.head = nil
    head_node
  end

  def increment_nodes(prev, current)
    prev = current
    current = current.link
    return prev, current
  end

  def count_nodes(current, count)
    while current.link
      current = current.link
      count += 1
    end
    count
  end

  def find_pre_tail
    prev = head
    while prev.link != tail
      prev = prev.link
    end
    prev
  end

  def node_at_index(index)
    current = head
    index.times do
      current.link ? current = current.link : return
    end
    current
  end

  def node_at_value(value, current)
    while current.link
      return current if current.data == value
      return current.link if current.link.data == value
      current = current.link
    end
  end

  def includes?(data)
    current_node = self.head
    loop do
      return true if current_node.data == data
      return false if current_node.link.nil?
      current_node = current_node.link
    end
  end

  def pop
    current = self.head
    return if current.nil?
    return remove_head(current) if !current.link
    prev = find_pre_tail
    tail = prev.link
    prev.link = nil
    tail
  end

  def count
    return 0 if !self.head
    return 1 if !self.head.link
    count_nodes(head, 1)
  end

  def tail
    return if self.head.nil?
    current = self.head
    while current.link
      current = current.link
    end
    current
  end

  def find_by_index(index)
    return if !self.head
    return self.head if index == 0
    node_at_index(index)
  end

  def find_by_value(value)
    current = head
    return if current.nil?
    return current if current.data == value
    node_at_value(value, current)
  end

  def remove_by_index(index)
    if index == 0
      self.head = nil
    elsif index == 1
      previous_node = self.head
      current_node = previous_node.link
      previous_node.link = current_node.link
    else
      current_node = self.head.link
      previous_node = head

      (index - 1).times do
        if current_node.link
          previous_node = current_node
          current_node = current_node.link
        end
      end
      previous_node.link = current_node.link
    end
  end

  def remove_by_value(value)
    return if self.head.nil?
    current_node = head
    if current_node.data == value
      next_node = current_node.link
      self.head = next_node
    else
      if current_node.link
        previous_node = current_node
        current_node = current_node.link
        while current_node.link
          if current_node.data == value
            next_node = current_node.link
            previous_node.link = next_node
            return
          else
            previous_node = current_node
            current_node = current_node.link
          end
        end
      end
    end
  end

  def find_distance(node_a, node_b)
    return if self.head.nil?
    return 0 if node_a == node_b
    current_node = head
    includes_a = false
    includes_b = false

    while current_node.link
      if current_node == node_a ||
         current_node.link == node_a
        includes_a = true
      end
      if current_node == node_b ||
         current_node.link == node_b
        includes_b = true
      end
      current_node = current_node.link
    end

    if includes_a && includes_b
      distance = 0
      measure_distance = false
      current_node = head

      while current_node != node_b
        if current_node == node_a
          measure_distance = true
        end
          current_node = current_node.link
        if measure_distance == true
          distance += 1
        end
      end

      if distance == 0
        measure_distance == false

        while current_node != node_a
          if current_node == node_b
            measure_distance = true
          end

          current_node = current_node.link

          if measure_distance == true
            distance += 1
          end
        end
      end
    end
    distance
  end
end

list = List.new
node = Node.new
node2 = Node.new

node.link = node2
list.head = node
list.pop
