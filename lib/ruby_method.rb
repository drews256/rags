class RubyMethod < Struct.new(:name, :parent_class, :file_name, :line_num)
  attr_accessor :name, :parent_class, :file_name, :line_num

  def initialize name='', parent_class='', file_name='', line_num=0
    self.name = name
    self.parent_class = parent_class
    self.file_name = file_name
    self.line_num = line_num
  end

end
