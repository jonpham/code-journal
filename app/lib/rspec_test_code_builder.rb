# require_relative './RubyCodeBuilder.rb'
require 'JSON'

class RspecTestCodeBuilder < RubyCodeBuilder
  def initialize(test_code_input)
    @test_code_id = test_code_input[:id]
    @expected_test_arguments = test_code_input[:input]
    @expected_return_result = test_code_input[:output]
    @test_description = test_code_input[:description]
    @assertion_type = test_code_input[:assertion_type] || 'eq'
  end

  def build_test(method_number="00",args=@expected_test_arguments,expectation=@expected_return_result)
    test_code_string = "uut = build_uut()\n"
    test_code_string += "args = JSON.parse(#{JSON.dump(args)})\n"
    test_code_string += "expect(uut.method#{method_number}(args)).#{@assertion_type}(JSON.parse(#{JSON.dump(expectation)}))\n"
    
    # Instantiate ClassName/ UUT
    test_case_string = "it '#{@test_description}' do\n"
    test_case_string += indent_each_line(test_code_string)
    test_case_string += "end\n"
    return test_case_string
  end

  def run
    return 0
  end
end

