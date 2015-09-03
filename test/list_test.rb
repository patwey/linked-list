require 'minitest'
require 'list'
require 'node'

class ListTest < Minitest::Test
  def setup
    @list = List.new
    @node = Node.new
    @node_b = Node.new
    @node_c = Node.new
    @node_d = Node.new
    @node_e = Node.new
  end

  def test_head_defaults_to_nil
    assert_nil @list.head
  end

  def test_list_accepts_node_as_head
    @list.head = @node

    assert_equal @node, @list.head
  end

  def test_includes_returns_false_if_value_not_in_list
    @node.data = 'a'
    @list.head = @node

    refute @list.includes?('b')
  end

  def test_includes_true_if_value_in_head
    @node.data = 'a'
    @list.head = @node

    assert @list.includes?('a')
  end

  def test_includes_true_if_value_in_middle
    @node.data = 'a'
    @node_b.data = 'b'
    @node_c.data = 'c'

    @node.link = @node_b
    @node_b.link = @node_c

    @list.head = @node

    assert @list.includes?('b')
  end

  def test_includes_true_if_value_in_tail
    @node.data = 'a'
    @node_b.data = 'b'

    @node.link = @node_b
    @list.head = @node

    assert @list.includes?('b')
  end

  def test_append_adds_node_to_head_if_list_is_empty
    @list.append(@node)

    assert_equal @node, @list.head
  end

  def test_append_adds_node_to_end_of_list
    @list.head = @node
    @list.append(@node_b)

    assert_equal @node_b, @node.link
  end

  def test_prepend_points_head_to_node_if_list_empty
    @list.prepend(@node)

    assert_equal @node, @list.head
  end

  def test_prepend_inserts_new_node_at_head
    @list.head = @node
    @list.prepend(@node_b)

    assert_equal @node_b, @list.head
    assert_equal @node, @node_b.link
  end

  def test_pop_returns_nil_with_empty_list
    assert_nil @list.pop
  end

  def test_pop_returns_head_with_one_node
    @list.head = @node

    assert_equal @node, @list.pop
    assert_nil @list.head
  end

  def test_pop_returns_tail
    @node.link = @node_b
    @list.head = @node

    assert_equal @node_b, @list.pop

    @node.link = @node_b
    @node_b.link = @node_c
    @node_c.link = @node_d
    @node_d.link = @node_e

    @list.head = @node

    assert_equal @node_e, @list.pop
  end

  def test_count_returns_number_of_nodes_in_list
    assert_equal 0, @list.count

    @list.head = @node
    assert_equal 1, @list.count

    @node.link = @node_b
    assert_equal 2, @list.count

    @node.link = @node_b
    @node_b.link = @node_c
    @node_c.link = @node_d
    @node_d.link = @node_e
    @list.head = @node

    assert_equal 5, @list.count
  end

  def test_head_returns_list_head
    assert_nil @list.head

    @list = List.new(@node)
    assert_equal @node, @list.head
  end

  def test_tail_returns_last_node
    assert_nil @list.tail

    @node.link = @node_b
    @list.head = @node

    assert_equal @node_b, @list.tail
  end

  def test_find_by_index_returns_node_at_index
    assert_nil @list.find_by_index(0)

    @list.head = @node
    assert_nil @list.find_by_index(1)

    @list.head = @node
    assert_equal @list.head, @list.find_by_index(0)

    @node.link = @node_b
    @list.head = @node
    assert_equal @node_b, @list.find_by_index(1)

    @node.link = @node_b
    @node_b.link = @node_c
    @node_c.link = @node_d
    @node_d.link = @node_e
    @list.head = @node
    assert_equal @node_e, @list.find_by_index(4)
  end

  def test_find_by_value_returns_first_node_with_value
    assert_nil @list.find_by_value('a')

    @node.data = 'a'
    @list.head = @node
    assert_nil @list.find_by_value('b')

    @node.data = 'a'
    @list.head = @node
    assert_equal @node, @list.find_by_value('a')

    @node.link = @node_b
    @node_b.data = 'b'
    @list.head = @node
    assert_equal @node_b, @list.find_by_value('b')

    @node.data = 'a'
    @node.link = @node_b
    @node_b.data = 'a'
    @list.head = @node
    assert_equal @node, @list.find_by_value('a')
  end

  def test_remove_by_index_removes_node_at_index
    assert_nil @list.remove_by_index(0)

    @list.head = @node
    @list.remove_by_index(0)
    assert_nil @list.head

    @node.link = @node_b
    @list.head = @node
    @list.remove_by_index(1)
    assert_nil @node.link
  end

  def test_remove_by_index_one_links_adjacent_nodes
    @node.link = @node_b
    @node_b.link = @node_c

    @list.head = @node
    @list.remove_by_index(1)
    assert_equal @node_c, @node.link

    @node.link = @node_b
    @node_b.link = @node_c
    @node_c.link = @node_d

    @list.head = @node
    @list.remove_by_index(2)
    assert_equal @node_d, @node_b.link
  end

  def test_remove_by_value_removes_node_with_value
    assert_nil @list.remove_by_value('a')

    @node.data = 'a'
    @list.head = @node
    @list.remove_by_value('a')
    assert_nil @list.head
  end

  def test_remove_by_value_removes_first_node_with_value
    @node.data = 'a'
    @node_b.data = 'a'
    @node.link = @node_b

    @list.head = @node
    @list.remove_by_value('a')

    assert_equal @node_b, @list.head
  end

  def test_remove_by_value_links_adjecent_nodes
    @node.data = 'a'
    @node_b.data = 'b'
    @node_c.data = 'c'

    @node.link = @node_b
    @node_b.link = @node_c

    @list.head = @node
    @list.remove_by_value('b')

    assert_equal @node_c, @node.link
  end

  def test_find_distance_returns_distance_between_two_nodes
    assert_nil @list.find_distance(@node_a, @node_b)

    @list.head = @node

    assert_nil @list.find_distance(@node, Node.new)
    assert_nil @list.find_distance(Node.new, @node)

    @list.head = @node

    assert_equal 0, @list.find_distance(@node, @node)

    @node.link = @node_b
    @list.head = @node
    distance = @list.find_distance(@node, @node_b)

    assert_equal 1, distance

    @node.link = @node_b
    @list.head = @node

    assert_equal 1, @list.find_distance(@node_b, @node)

    @node.link = @node_b
    @node_b.link = @node_c
    @node_c.link = @node_d
    @node_d.link = @node_e

    @list.head = @node

    assert_equal 4, @list.find_distance(@node, @node_e)
  end
end
