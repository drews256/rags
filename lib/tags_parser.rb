class TagsParser
  attr_accessor :ctags, :ctag

  def initialize
    self.ctag = {}
    self.ctags = Ctags.new([], {})
  end

  def read_file file
    file = File.open(file, 'r') do |f|
      f.each_line do |line|
        set_ctag_information line.split("\t")
      end
    end
  end

  def set_ctag_information tag
    self.ctag = {'name' => set_name(tag[0]),
             'file' => set_file(tag[1]),
             'location' => set_location(tag[2])
            }
    set_type_and_parent tag
    self.ctags.tags << self.ctag
  end

  def set_name name
    name.strip unless name.to_s.empty?
  end

  def set_file file
    file.strip unless file.to_s.empty?
  end

  def set_location location
    location.gsub(/\/|\^|\$|\;|\\|\"|\ + /,'') unless location.to_s.empty?
  end

  def set_type_and_parent tag
    invalid_type tag
  end

  def invalid_type tag
    if tag[3] =~ /def(.*)/
      shift_type tag
    else
      self.ctag['type'] = tag[3].strip unless tag[3].to_s.empty?
      set_parent tag[4]
    end
  end

  def shift_type tag
    set_location tag[3].strip
    self.ctag['type'] = tag[4].strip unless tag[4].to_s.empty?
    set_parent tag[5]
    tag.delete_at(5)
  end

  def set_parent parent
    self.ctag['parent'] = parent.strip unless parent.to_s.empty?
  end

  def tags key
    self.ctags.map { |h| h[key] }
  end
end
