module FileSystemReadWriter
  attr_accessor :file
  def open_file(file_path)
    if File.exist?(file_path)
      @file = File.open()
  end

  def close_file(file_path)
  end

  def append_to_file(text,file_path)
  end

  def overwrite_file(text,file_path)
  end

  def read_from_file(file_path)
    throw Exception
  end

  def get_line_from_file(line_number,file_path)
  end

  def delete_file(file_path)
  end

  def check_permissions(file_path)
  end
end