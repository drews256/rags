class Classes < Struct.new(:names, :parent_class)
  attr_accessor :classes, :names, :parent_class

  def initialize names=[], parent_class=[]
    self.names = names
    self.parent_class
  end
end
