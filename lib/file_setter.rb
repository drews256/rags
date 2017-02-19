class FileSetter

  def self.set ctags
    ctags.tags.map do |tag|
      set_filetype tag
    end
    ctags
  end

  def self.set_filetype tag
    file = tag['file'].split('/')
    set_rails_file tag if file.first == 'app'
    tag
  end

  def self.set_rails_file tag
    file_types = %w(models controllers interactions helpers bus channels \
      jobs mailers views serializers)

    if file_types.include?(tag['file'].split('/')[1])
      tag['file_type'] = "#{tag['file'].split('/')[1]}"
      tag['file_name'] = "#{tag['file'].split('/').last}"
    end
    tag
  end

end
