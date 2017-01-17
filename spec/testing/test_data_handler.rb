require 'JSON'

module Testing
  class TestDataHandler
    def self.read_file_to_s(file_path)
      return File.read(file_path) if (File::readable?(file_path) && File::file?(file_path))
    end

    def self.compare_to_file(string,file_path)
      test_string = read_file_to_s(file_path)
      return (string == test_string)
    end

    def self.write_to_json(data_object,file_path)
      File.open(file_path, "w") do |file|
        file.puts JSON.pretty_generate(data_object)
      end
    end

    def self.read_json_file(file_path)
      if (File.exists?(file_path)) 
        file = File.read(file_path)
        return JSON.parse(file)
      else
        puts "File Does not exist at #{file_path}"
      end
    end

    def self.write_to_yaml(data_object,file_path)
      File.open(file_path, "w") do |file|
        file.puts YAML.dump(data_object)
      end
    end

    def self.read_yaml_file(file_path)
      file = File.read(file_path)
      return YAML.load(file)
    end

    def self.write_string_to_file(string,file_path)
      File.open(file_path, "w") do |file|
        file.puts string
      end
    end

    def self.delete_tmp_files(directory)
      Dir.foreach(directory) do |file|
        File.delete(file) if (file.match(/delete.+\.rb$/)!=nil)
      end
    end
  end
end
