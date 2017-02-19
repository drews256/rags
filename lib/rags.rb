require 'pry'
require_relative 'tags_parser'
require_relative 'file_setter'
require_relative 'ctags'

class Rags
  attr_accessor :ctags, :parser

  def generate_ctags
    self.parser = TagsParser.new
    tags_file = File.expand_path("../../../brivity-core/tags", __FILE__)
    self.parser.read_file(tags_file)
    self.ctags = FileSetter.set self.parser.ctags
    self.ctags.set_all_file_types
  end
end
