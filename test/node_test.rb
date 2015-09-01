require 'node'
require 'minitest'

class NodeTest < Minitest::Test
  def test_link_is_nil_when_not_passed_a_node
    assert_equal nil, Node.new.link
  end
end
