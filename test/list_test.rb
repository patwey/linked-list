$LOAD_PATH << __dir__ # delete this eventually

require 'minitest'
require 'list'
require 'node'

class ListTest < Minitest::Test
  def test_head_defaults_to_nil
    assert_nil List.new.head
  end

  def test_list_accepts_node_as_head
    node = Node.new('HEAD')
    list = List.new(node)

    assert_equal node, list.head
  end

  def test_includes_returns_true_if_value_in_list
    node_a = Node.new('a')
    list = List.new(node_a)

    node_b = Node.new('b')
    node_a.next_node = node_b

    assert list.includes?('b')
  end

  def test_includes_returns_false_if_value_not_in_list
    node_a = Node.new('a')
    list = List.new(node_a)

    refute list.includes?('b')
  end

  def test_includes_returns_true_if_value_in_head
    head_node = Node.new('a')
    list = List.new(head_node)

    assert list.includes?('a')
  end

  def test_includes_returns_true_if_value_in_tail
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

  def test_prepend_points_head_to_node_if_list_empty
    list = List.new
    node = Node.new

    list.prepend(node)

    assert_equal node, list.head
  end

  def test_prepend_sets_head_to_new_node_if_list_has_head
    node_a = Node.new
    list = List.new(node_a)

    new_node = Node.new
    list.prepend(new_node)

    assert_equal new_node, list.head
  end

  def test_prepend_links_new_node_to_previous_head
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

    assert_nil list.head
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
    assert_nil list.pop
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

  def test_count_is_zero_with_empty_list
    list = List.new
    assert_equal 0, list.count
  end

  def test_count_counts_one_node
    list = List.new(Node.new)
    assert_equal 1, list.count
  end

  def test_count_counts_two_nodes
    node_a = Node.new
    node_b = Node.new
    node_a.next_node = node_b

    list = List.new(node_a)

    assert_equal 2, list.count
  end

  def test_count_counts_six_nodes
    node_f = Node.new
    node_e = Node.new('', node_f)
    node_d = Node.new('', node_e)
    node_c = Node.new('', node_d)
    node_b = Node.new('', node_c)
    node_a = Node.new('', node_b)

    list = List.new(node_a)

    assert_equal 6, list.count
  end

  def test_head_returns_nil_with_empty_list
    list = List.new
    assert_nil list.head
  end

  def test_head_returns_first_node
    node = Node.new
    list = List.new(node)

    assert_equal node, list.head
  end

  def test_tail_returns_nil_with_empty_list
    list = List.new
    assert_nil list.tail
  end

  def test_tail_returns_last_node_with_two_nodes
    node_b = Node.new
    node_a = Node.new('', node_b)

    list = List.new(node_a)

    assert_equal node_b, list.tail
  end

  def test_find_by_index_returns_nil_with_empty_list
    list = List.new

    assert_nil list.find_by_index(0)
  end

  def test_find_by_index_nil_if_index_doesnt_exist
    node = Node.new
    list = List.new(node)

    assert_nil list.find_by_index(1)
  end

  def test_find_by_index_zero_returns_head
    node = Node.new
    list = List.new(node)

    assert_equal list.head, list.find_by_index(0)
  end

  def test_find_by_index_one_returns_second_node
    node_b = Node.new
    node_a = Node.new('', node_b)
    list = List.new(node_a)

    assert_equal node_b, list.find_by_index(1)
  end

  def test_find_by_index_five_returns_sixth_node
    node_f = Node.new
    node_e = Node.new('', node_f)
    node_d = Node.new('', node_e)
    node_c = Node.new('', node_d)
    node_b = Node.new('', node_c)
    node_a = Node.new('', node_b)

    list = List.new(node_a)

    assert_equal node_f, list.find_by_index(5)
  end

  def test_find_by_value_returns_nil_with_empty_list
    list = List.new
    assert_nil list.find_by_value('a')
  end

  def test_find_by_value_returns_nil_if_value_doesnt_exist
    node_b = Node.new('b')
    node_a = Node.new('a', node_b)

    list = List.new

    assert_nil list.find_by_value('c')
  end

  def test_find_by_value_returns_head_if_it_holds_value
    node_a = Node.new('a')
    list = List.new(node_a)

    assert_equal node_a, list.find_by_value('a')
  end

  def test_find_by_value_returns_tail_if_it_holds_value
    node_b = Node.new('b')
    node_a = Node.new('a', node_b)
    list = List.new(node_a)

    assert_equal node_b, list.find_by_value('b')
  end

  def test_find_by_value_returns_first_node_with_value
    node_b = Node.new('a')
    node_a = Node.new('a', node_b)
    list = List.new(node_a)

    assert_equal node_a, list.find_by_value('a')
  end

  def test_remove_by_index_returns_nil_with_empty_list
    list = List.new
    assert_nil list.remove_by_index(0)
  end

  def test_remove_by_index_zero_removes_head
    node = Node.new
    list = List.new(node)

    list.remove_by_index(0)

    assert_nil list.head
  end

  def test_remove_by_index_one_removes_second_node
    node_b = Node.new
    node_a = Node.new('', node_b)
    list = List.new(node_a)

    list.remove_by_index(1)
    node_a_link = node_a.next_node

    assert_nil node_a_link
  end

  def test_remove_by_index_one_links_head_with_two
    node_c = Node.new
    node_b = Node.new('', node_c)
    node_a = Node.new('', node_b)
    list = List.new(node_a)

    list.remove_by_index(1)
    node_a_link = node_a.next_node

    assert_equal node_c, node_a_link
  end

  def test_remove_by_index_two_links_one_with_three
    node_d = Node.new
    node_c = Node.new('', node_d)
    node_b = Node.new('', node_c)
    node_a = Node.new('', node_b)

    list = List.new(node_a)

    list.remove_by_index(2)
    node_b_link = node_b.next_node

    assert_equal node_d, node_b_link
  end

  def test_remove_by_index_four_links_node_three_with_five
    node_f = Node.new
    node_e = Node.new('', node_f)
    node_d = Node.new('', node_e)
    node_c = Node.new('', node_d)
    node_b = Node.new('', node_c)
    node_a = Node.new('', node_b)

    list = List.new(node_a)

    list.remove_by_index(4)
    node_d_link = node_d.next_node

    assert_equal node_f, node_d_link
  end

  def test_remove_by_value_returns_nil_with_empty_list
    list = List.new
    assert_nil list.remove_by_value('a')
  end

  def test_remove_by_value_removes_head_if_it_holds_value
    node_a = Node.new('a')
    list = List.new(node_a)

    list.remove_by_value('a')

    assert_nil list.head
  end

  def test_remove_by_value_returns_first_node_holding_value
    node_b = Node.new('a')
    node_a = Node.new('a', node_b)
    list = List.new(node_a)

    list.remove_by_value('a')

    assert_equal node_b, list.head
  end

  def test_remove_by_value_links_adjecent_nodes
    node_c = Node.new
    node_b = Node.new('b', node_c)
    node_a = Node.new('a', node_b)

    list = List.new(node_a)
    list.remove_by_value('b')
    node_a_link = node_a.next_node

    assert_equal node_c, node_a_link
  end
end
