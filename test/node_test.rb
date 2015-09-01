require 'node'
require 'minitest'

class NodeTest < Minitest::Test
  def test_link_defaults_to_nil
    assert_equal nil, Node.new.link
  end

  def test_data_defaults_to_empty_string
    assert_equal '', Node.new.data
  end
end
