require 'node'
require 'minitest'

class NodeTest < Minitest::Test
  attr_accessor :node, :node_b, :data, :link

  def setup
    @node = Node.new
    @node_b = Node.new
  end

  def test_link_defaults_to_nil
    assert_nil @node.link
  end

  def test_data_defaults_to_nil
    assert_nil @node.data
  end

  def test_node_accepts_different_data_types
    @node.data = 1
    assert_equal 1, @node.data

    @node.data = 'Hello World'
    assert_equal 'Hello World', @node.data

    @node.data = [1, 2, 3]
    assert_equal [1, 2, 3], @node.data
  end

  def test_node_accepts_node_as_link
    @node.link = node_b
    assert_equal @node_b, @node.link
  end
end
