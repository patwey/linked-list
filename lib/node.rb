class Node
  attr_accessor :data, :link

  def initialize(data='', link=nil)
    @link = link
    @data = data
  end
end
