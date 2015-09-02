class Node
  attr_accessor :data, :next_node

  def initialize(data=nil, next_node=nil)
    @next_node = next_node
    @data = data
  end
end
