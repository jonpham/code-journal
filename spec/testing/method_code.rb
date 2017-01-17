module Testing
  class MethodCode
    attr_accessor :lesson_module_id, :method_name, :arguments, 
      :return_type, :source_code, :module_ordinal,
      :test_codes, :solution_code, :user_code

    def initialize(input_data)
      @method_name = input_data[:method_name]
      @arguments = input_data[:arguments]
      @return_type = input_data[:return_type]
      @source_code = input_data[:source_code]
      @module_ordinal = input_data[:module_ordinal]
      @test_codes = Array.new
    end

    def add_test_code(test_code)
      @test_codes.push(test_code)
    end

    def add_solution(solution_code)
      @solution_code = solution_code
    end

    def add_user_code(code_snippet)
      @user_code = code_snippet
    end
  end
end