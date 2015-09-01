require 'minitest'
require 'list'

class ListTest < Minitest::Test
  def test_head_defaults_to_nil
    assert_equal nil, List.new.head
  end
end
