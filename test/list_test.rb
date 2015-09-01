require 'minitest'
require 'list'

class ListTest < Minitest::Test
  def test_empty_list_has_nil_head
    assert_equal nil, List.new.head
  end
end
