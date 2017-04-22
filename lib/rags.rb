require 'pry'
require_relative 'tags_parser'
require_relative 'file_setter'
require_relative 'ctags'

require_relative 'ruby_parser'
require_relative 'ruby_method'
require_relative 'files'
require_relative 'classes'

class Rags
  attr_accessor :ctags, :parser

  def generate_ctags
    self.parser = TagsParser.new
    tags_file = File.expand_path("../../../brivity-core/tags", __FILE__)
    self.parser.read_tags_file_and_parse_each_line(tags_file)
    self.ctags = FileSetter.set self.parser.ctags
    self.ctags.set_all_file_types
  end

  def parse_ruby
    ruby_file = File.expand_path("../../../brivity/app/models/person.rb", __FILE__)
    ruby_parser = RubyParser.new(ruby_file)
  end

end
