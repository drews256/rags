class Files < Struct.new(:names)
  attr_accessor :names

  def initialize names=[]
    self.names = names
  end

end
