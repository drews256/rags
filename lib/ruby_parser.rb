class RubyParser
  attr_accessor :methods, :classes, :file_name, :file, :line_num, :class_name, :files

  def initialize(file)
    self.classes = Classes.new()
    self.files = Files.new()
    self.file = File.open(file, 'r')
    set_file_name file
    read_and_parse_ruby_file
  end

  def read_and_parse_ruby_file
    line_number = 0
    file do |f|
      f.each_line do |line|
        binding.pry
        match_ruby_keyword(line.split("\t"))
        puts("#{line_number}" + "#{line}")
        line_number += 1
      end
    end
  end

  def match_ruby_keyword line
    puts 'matching'
    set_class(line) if line.to_s.include?('class')
    set_method(line) if line.to_s.include?('def')
    finish_method(line) if line.to_s.include?('end')
  end

  def set_file_name file
    files.names << file.split('/').last
  end

  def pull_out_class_name line
    line.split(' ').second
  end

  def set_class line
    self.class_name = pull_out_class_name line
    Classes.names << class_name
    puts Classes
  end

  def set_method line
    RubyMethod.new(line.split(' ').second, class_name, file_name, line_num)
  end

  def finish_method line
    puts 'found end'
  end

end
