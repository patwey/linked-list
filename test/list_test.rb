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
    list = List.new
    node_a = Node.new('a')
    list.head = node_a

    node_b = Node.new('b')
    node_a.next_node = node_b
    
    assert list.includes?('b')
  end
end
