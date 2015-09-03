require 'node'

class List
  attr_accessor :head

  def initialize(head = nil)
    @head = head
  end

  def append(new_node)
    self.head = new_node if head.nil?
    tail.link = new_node
  end

  def prepend(new_node)
    new_node.link = head
    self.head = new_node
  end

  def remove_head(head_node)
    self.head = nil
    head_node
  end

  def tail
    return if head.nil?
    current = head
    current = current.link while current.link
    current
  end

  def pre_tail
    prev = head
    prev = prev.link while prev.link != tail
    prev
  end

  def increment_nodes(prev, current)
    prev = current
    current = current.link
    return prev, current
  end

  def includes?(data)
    current_node = head
    loop do
      return true if current_node.data == data
      return false if current_node.link.nil?
      current_node = current_node.link
    end
  end

  def includes_node?(node)
    current_node = head
    loop do
      return true if current_node == node
      return false if current_node.link.nil?
      current_node = current_node.link
    end
  end

  def pop
    current = head
    return if current.nil?
    return remove_head(current) unless current.link
    prev = pre_tail
    tail = prev.link
    prev.link = nil
    tail
  end

  def count_nodes(current, count)
    while current.link
      current = current.link
      count += 1
    end
    count
  end

  def count
    return 0 unless head
    return 1 unless head.link
    count_nodes(head, 1)
  end

  def node_at_index(index)
    current = head
    index.times do
      current.link ? current = current.link : return
    end
    current
  end

  def find_by_index(index)
    return unless head
    return head if index == 0
    node_at_index(index)
  end

  def node_prev_index(index, prev, current)
    (index - 1).times do
      prev, current = increment_nodes(prev, current) if current.link
    end
    return prev, current
  end

  def remove_by_index(index)
    self.head = nil if index == 0
    prev = head
    prev.link = prev.link.link if index == 1
    return if index < 2
    current = prev.link
    prev, current = node_prev_index(index, prev, current)
    prev.link = current.link
  end

  def node_at_value(value, current)
    while current.link
      return current if current.data == value
      return current.link if current.link.data == value
      current = current.link
    end
  end

  def find_by_value(value)
    current = head
    return if current.nil?
    return current if current.data == value
    node_at_value(value, current)
  end

  def node_prev_value(value, prev, current)
    while current.link
      return prev, current if current.data == value
      return current, current.link if current.data == value
      prev, current = increment_nodes(prev, current)
    end
  end

  def remove_by_value(value)
    return if head.nil?
    current = head
    if current.data == value
      self.head = current.link
    else
      prev, current = node_prev_value(value, prev, current)
      prev.link = current.link
    end
  end

  def distance(a, b)
    distance = 0
    measure = false
    current = head
    while current != b
      measure = true if current == a
      current = current.link
      distance += 1 if measure
    end
    distance
  end

  def find_distance(a, b)
    return if head.nil?
    return 0 if a == b
    if includes_node?(b) && includes_node?(a)
      distance = distance(a, b)
      distance = distance(b, a) if distance == 0
    end
    distance
  end
end
