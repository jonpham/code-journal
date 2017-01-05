require './CodeBuilder.rb'
require './tests/TestData.rb'

class ClassCodeBuilder < CodeBuilder
  attr_accessor :method_set, :code_snippets, :class_tests

  def initialize(lesson_name,variables)
    @class_name = lesson_name
    @class_variables = variables
    @method_set = Array.new
    @code_snippets = Array.new
    @class_tests = Array.new
  end

  def add_method(method_builder)
    @method_set.push(method_builder)
  end

  def add_test(test_builder)
    @method_set.push(test_builder)
  end

  def add_code_snippet(code_snippet)
    @code_snippets.push(code_snippet)
  end

  def set_uut
  end

  def set_ctor
  end

  def build_method_runners
    # Add ModuleX methods to wrap intended methods
  end

  def build_solution_runners
    # Add ModuleX methods to wrap intended methods
  end

  def build_class_code
  end

  def build_tests
  end

  def build_spec
    # Return Executable RSPEC File as String
  end

  def build_markup
    # Return Class as Markdown
  end
end

# Test Code
# lesson_class_builder = ClassCodeBuilder.new(class_name,variables)
# lesson_class_builder.set_run_method(run_code);
# lesson_class_builder.set_ctor(ctor_code);
# lesson_class_builder.set_uut(uut_code);
# # Add Class Tests
# class_test = TestCodeBuilder.new(test_args)
# lesson_class_builder.add_test(class_test)

RSpec.describe ClassCodeBuilder do 
  test_data = Testing::TestDataHandler.read_json_file('tests/data/class_code_builder.json');
  # TEST CODE (Lesson)
  it 'should consolidate "module_codes" passed in to create single class code snippets and executable rspec.' do 
    uut = ClassCodeBuilder.new(test_data["name"],test_data["arguments"])
    expect(uut.build_class_code).to eq(Testing::TestDataHandler.read_file_to_s('tests/data/class_code_1.rb'))
  end

  # # TEST CODE (Module)
  # describe '#build_class_code' do 
  #   it 'should be able to create a basic class just after initialization' do
  #     uut = ClassCodeBuilder.new(test_data["name"],test_data["arguments"])
  #     uut.build_class_code
  #     expect(uut.build_class_code).to eq(Testing::TestDataHandler.read_file_to_s('tests/data/class_code_1.rb'))    
  #   end
  # end

  # describe '#build_tests' do 
  #   it "should loop through each method in the 'method_set' and build its test code." do
  #   end
  # end

  # describe '#build_spec' do
  # end

  # describe '#build_markup' do 
  # end
end