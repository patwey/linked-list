class Node
  attr_accessor :data, :next_node

  def initialize(data='', next_node=nil)
    @next_node = next_node
    @data = data
  end
end
