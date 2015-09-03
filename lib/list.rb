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

  def remove_by_index(index)
    if index == 0
      self.head = nil
    elsif index == 1
      previous_node = self.head
      current_node = previous_node.next_node
      previous_node.next_node = current_node.next_node
    else
      current_node = self.head.next_node
      previous_node = head

      (index - 1).times do
        if current_node.next_node
          previous_node = current_node
          current_node = current_node.next_node
        end
      end
      previous_node.next_node = current_node.next_node
    end
  end

  def remove_by_value(value)
    return if self.head.nil?
    current_node = head
    if current_node.data == value
      next_node = current_node.next_node
      self.head = next_node
    else
      if current_node.next_node
        previous_node = current_node
        current_node = current_node.next_node
        while current_node.next_node
          if current_node.data == value
            next_node = current_node.next_node
            previous_node.next_node = next_node
            return
          else
            previous_node = current_node
            current_node = current_node.next_node
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
    while current_node.next_node
      if current_node == node_a ||
         current_node.next_node == node_a
        includes_a = true
      end
      if current_node == node_b ||
            current_node.next_node == node_b
        includes_b = true
      end
      current_node = current_node.next_node
    end

    if includes_a && includes_b
      distance = 0
      current_node = head

      while current_node != node_b
        if current_node == node_a
          distance += 1
          current_node = current_node.next_node
        else
          current_node = current_node.next_node
        end
      end

      if distance == 0
        while current_node != node_a
          if current_node == node_b
            distance += 1
            current_node = current_node.next_node
          else
            current_node = current_node.next_node
          end
        end
      end
    end
    distance
  end

end
