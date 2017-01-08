require_relative './CodeBuilder.rb'
require 'rspec'

class TestCodeBuilder < CodeBuilder
  def initialize(test_code_input)
    @test_code_id = test_code_input[:id]
    @expected_test_arguments = test_code_input[:input]
    @expected_return_result = test_code_input[:output]
    @test_description = test_code_input[:description]
    @assertion_type = test_code_input[:assertion_type] || 'eq'
  end

  def build_test(method_name,args)
    test_code += "uut = instantiate_uut()\n"
    test_code += "#{args[:data]}"
    test_code += "expect(uut.#{method_name}(#{args[:string]})).to #{@assertion_type}(@expected_return_result)\n"
    # Instantiate ClassName/ UUT
    test_code = indent_each_line(test_code,1)
    test_code.prepend("it '#{@test_description}' do\n")
    test_code << "end\n"
    return test_code
  end

  def run
    return 0
  end
end

# MethodName
# Test_Set for ARGS
# Test_Exectation with ARGS
# TestDescription
# Method Expectation

### SHOULD CREATE ###
#   it 'should return "This is me saying, hello world!"' do
#     uut = SampleLesson.new 
#     test_set1=[]
#     expect(uut.module1(test_set1)).to eq('This is me saying, hello world!')
#   end
#####################

# Test Code
RSpec.describe TestCodeBuilder do 
  # TEST CODE (Lesson)
  it 'should consolidate the Data from a TestCode Module to build a the RSpec Test Set from Stored Data.' do 
    # uut = TestCodeBuilder.new({})
    # expect(uut.run).to eq(0)
  end

  # TEST CODE (Module)
  describe '#build_test' do 
  end
end
