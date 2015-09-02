$LOAD_PATH << __dir__ # delete this eventually

require 'node'
require 'minitest'

class NodeTest < Minitest::Test
  def test_next_node_defaults_to_nil
    assert_nil Node.new.next_node
  end

  def test_data_defaults_to_nil
    assert_nil Node.new.data
  end

  def test_node_accepts_number_as_data
    node = Node.new(1)
    assert_equal 1, node.data
  end

  def test_node_accepts_string_as_data
    node = Node.new('Hello World')
    assert_equal 'Hello World', node.data
  end

  def test_node_accepts_array_as_data
    node = Node.new([1, 2, 3])
    assert_equal [1, 2, 3], node.data
  end

  def test_node_accepts_node_as_next_node
    node_b = Node.new
    node_a = Node.new('data', node_b)
    assert_equal node_b, node_a.next_node
  end
end
