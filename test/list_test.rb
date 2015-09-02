$LOAD_PATH << __dir__ # delete this eventually

require 'minitest'
require 'list'
require 'node'

class ListTest < Minitest::Test
  def test_head_defaults_to_nil
    assert_equal nil, List.new.head
  end

  def test_list_accepts_node_as_head
    node = Node.new('HEAD')
    list = List.new(node)

    assert_equal node, list.head
  end

  def test_includes_returns_true_if_value_is_in_list
    node_a = Node.new('a')
    list = List.new(node_a)

    node_b = Node.new('b')
    node_a.next_node = node_b

    assert list.includes?('b')
  end

  def test_includes_returns_false_if_value_is_not_in_list
    node_a = Node.new('a')
    list = List.new(node_a)

    refute list.includes?('b')
  end

  def test_includes_returns_true_if_value_is_in_head
    head_node = Node.new('a')
    list = List.new(head_node)

    assert list.includes?('a')
  end

  def test_includes_returns_true_if_value_is_in_tail
    head_node = Node.new('head')
    list = List.new(head_node)

    tail_node = Node.new('tail')
    head_node.next_node = tail_node

    assert list.includes?('tail')
  end

  def test_append_adds_node_to_head_if_list_is_empty
    list = List.new
    node = Node.new
    list.append(node)

    assert_equal node, list.head
  end

  def test_append_adds_node_to_end_of_list
    node_a = Node.new('a')
    list = List.new(node_a)

    node_b = Node.new('b')
    list.append(node_b)
    tail = list.head.next_node

    assert_equal node_b, tail
  end

  def test_prepend_sets_head_to_new_node_if_list_is_empty
    list = List.new
    node = Node.new

    list.prepend(node)

    assert_equal node, list.head
  end

  def test_prepend_sets_head_to_new_node
    node_a = Node.new
    list = List.new(node_a)

    new_node = Node.new
    list.prepend(new_node)

    assert_equal new_node, list.head
  end

  def test_prepend_links_new_node_to_old_head
    node_a = Node.new
    list = List.new(node_a)

    new_node = Node.new
    list.prepend(new_node)

    assert_equal node_a, new_node.next_node
  end

  def test_pop_returns_head_with_one_node
    node_a = Node.new
    list = List.new(node_a)

    new_node = Node.new
    list.pop

    refute list.head
  end

  def test_pop_returns_last_with_two_nodes
    node_a = Node.new
    node_b = Node.new
    node_a.next_node = node_b

    list = List.new(node_a)
    assert_equal node_b, list.pop
  end

  def test_pop_returns_nil_with_empty_list
    list = List.new
    refute list.pop
  end

  def test_pop_returns_last_with_six_nodes
    node_f = Node.new
    node_e = Node.new('', node_f)
    node_d = Node.new('', node_e)
    node_c = Node.new('', node_d)
    node_b = Node.new('', node_c)
    node_a = Node.new('', node_b)

    list = List.new(node_a)
    assert_equal node_f, list.pop
  end

  def test_count_returns_zero_with_empty_list
    list = List.new
    assert_equal 0, list.count
  end

  def test_count_works_with_one_node
    list = List.new(Node.new)
    assert_equal 1, list.count
  end

  def test_count_works_with_two_nodes
    node_a = Node.new
    node_b = Node.new
    node_a.next_node = node_b

    list = List.new(node_a)

    assert_equal 2, list.count
  end

  def test_count_works_with_six_nodes
    node_f = Node.new
    node_e = Node.new('', node_f)
    node_d = Node.new('', node_e)
    node_c = Node.new('', node_d)
    node_b = Node.new('', node_c)
    node_a = Node.new('', node_b)

    list = List.new(node_a)

    assert_equal 6, list.count
  end
end
