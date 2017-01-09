require 'JSON'
require 'YAML'

module Testing

  class Lesson
    attr_accessor :lesson_modules

    def initialize
      @lesson_modules = Array.new
    end

    def add_module(lesson_module)
      @lesson_modules.push(lesson_module)
    end

    def get_module_by_ordinal(desired_ordinal)
      @lesson_modules.each do | lesson_module |
        return lesson_module if (lesson_module.lesson_ordinal == desired_ordinal)
      end
      return nil
    end

    def get_method_modules
      method_modules = Array.new;
      @lesson_modules.each do | lesson_module |
        method_modules.push(lesson_module) if (lesson_module.lesson_ordinal != 0)
      end
      return method_modules;
    end
  end

  class LessonModule
    attr_accessor :module_codes, :lesson_ordinal
    
    def initialize(lesson_ordinal)
      @module_codes = Array.new
      @lesson_ordinal=lesson_ordinal
    end

    def add_method_code(method_code)
      @module_codes.push(method_code)
    end

    def get_module_code(desired_ordinal)
      @module_codes.each do | module_code |
        return module_code if (module_code.module_ordinal == desired_ordinal)
      end
      return nil
    end
  end

  class MethodCode
    attr_accessor :lesson_module_id, :method_name, :arguments, 
      :return_type, :source_code, :module_ordinal,
      :test_codes, :solution_code, :code_snippet

    def initialize(input_data)
      @method_name = input_data[:method_name]
      @arguments = input_data[:arguments]
      @return_type = input_data[:return_type]
      @source_code = input_data[:source_code]
      @module_ordinal = input_data[:module_ordinal]
      @test_codes = Array.new
      @user_code = ""
    end

    def add_test_code(test_code)
      @test_codes.push(test_code)
    end

    def add_solution(solution_code)
      @solution_code = solution_code
    end

    def add_user_code(code)
      @user_code = code
    end
  end

  class TestCode
    attr_accessor :assertion_type, :expected_return, :expected_test_data, :test_description
    
    def initialize(input_data)
      @assertion_type = input_data[:assertion_type]
      @expected_return = input_data[:expected_return]
      @expected_test_data = input_data[:expected_test_data]
      @test_description = input_data[:test_description]
    end
  end

  class CodeSnippet
    attr_accessor :source_code

    def initialize(input_code)
      @source_code = input_code
    end
  end

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
  end
end














