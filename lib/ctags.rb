class Ctags < Struct.new(:tags, :tags_by_file, :tags_by_file_type)
  attr_accessor :file_type_tags

  def initialize tags=[], tags_by_file={}, tags_by_file_type={}
    self.tags = tags
    self.tags_by_file = tags_by_file
    self.tags_by_file_type = tags_by_file_type
    self.file_type_tags = []
  end

  def set_all_file_types
    file_types = %w(models controllers interactions helpers bus channels
      jobs mailers views serializers)
    file_types.each do |type|
      set_tags_by_file_type type
    end
  end

  def set_tags_by_file_type type
    tags = get_tags_by_type type
    self.tags_by_file_type["#{type}"] = tags
  end

  def get_tags_by_type type
    file_type_tags = []
    self.tags.each do |tag|
      next if tag.nil?
      file_type_tags << tag if tag['file_type'] == type
    end
    file_type_tags
  end

  def tags_by_file
    tags_by_file = @tags.map do |tag|
      next if tag.nil?
      tags << tag if tag['file_name'] == file
    end
  end
end
