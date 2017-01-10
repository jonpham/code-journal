require_relative './MethodCodeBuilder.rb'
require_relative './tests/TestClasses.rb'
require 'rspec'

class ClassCodeBuilder < CodeBuilder
  attr_accessor :method_set, :user_code_snippets, :class_tests, :solution_snippets, :class_methods

  def initialize(lesson_name,variables)
    @class_name = lesson_name
    @class_variables = variables if variables.class == Array # Assumes Array
    @method_set = Array.new # Module Method Storage
    @user_code_snippets = Array.new # Current User's Code Snippets
    @solution_snippets = Array.new # Built from Method_Set using Creator's Code Snippets
    @class_tests = Array.new # Contains Overall Class Tests
    @class_methods = Hash.new # initialize,run,build_uut, default methods
  end

  def add_method(method_builder)
    case method_builder.method_name
    when "run"
      set_run_method(method_builder)
    when "initialize"
      set_ctor(method_builder)
    when "build_uut"
      set_uut(method_builder)
    else
      @method_set.push(method_builder)
    end
  end

  def add_test(test_builder)
    @class_tets.push(test_builder)
  end

  def add_code_snippet(code_snippet)
    @code_snippets.push(code_snippet)
  end

  def set_ctor(constructor_code)
    # Set the 'initialize method' for the class
    initialize_method = "def initialize\n"
    initialize_method += indent_each_line(constructor_code.source_code)
    initialize_method += "\nend"
    @class_methods[:initialize]={string: initialize_method, builder: constructor_code}
  end

  def set_uut(uut_code)
    # Create a uut initializer method that will allow tests to call 'build_uut' 
    # to get an instance of a preloaded UUT for testing.
    uut_method = "def self.build_uut\n"
    uut_method += indent_each_line(uut_code.source_code)
    uut_method += "\nend"
    @class_methods[:build_uut]={string: uut_method, builder: uut_code}
  end

  def set_run_method(run_code)
    @class_methods[:run]={string: run_code.build_code("run"), builder: run_code}
  end

  def build_class_methods
    # FOR EACH CLASS METHOD in @class_methods
    class_method_string = ""
    @class_methods.each_value do |class_method|
      class_method_string += class_method[:string]
      class_method_string += "\n\n"
    end
    return class_method_string
  end

  def build_module_methods(with_solutions=false)
    # Generate Code String for Module Methods, if for Markdown use 
    # 'source_code' which should contain comments regarding instructions.
    # else swap in '###INSERT_HERE###' and then write in 
    # 'SOLUTION' code snippets
    module_method_string = ""
    # For each Module Method in @method_set
      # Build Either 
      # A) Solution Method
      # B) Readable Method 
    @method_set.each do |module_method|
      module_method_string += module_method.build_solution() if with_solutions
      module_method_string += module_method.build_code() unless with_solutions
      module_method_string += "\n\n"
    end
    # RETURN STRING
    return module_method_string.strip + "\n\n"
  end

  def build_snippet_methods
    # Generate Code String for User / Solution Code Methods
    code_snippet_string = ""
    # For Each Code Snippet in @user_code_snippets
    self.compile_code_snippets();
    @user_code_snippets.each do |code_snippet|
      code_snippet_string += code_snippet
      while (!code_snippet_string.end_with?("\n\n")) do
        code_snippet_string += "\n" 
      end
    end
    return code_snippet_string
  end

  def compile_code_snippets
    @user_code_snippets.clear
    @method_set.each do | method_builder | 
      @user_code_snippets.push(method_builder.user_code)
    end
  end

  def build_method_runners
    # Add ModuleX methods to wrap intended methods that shall run User Code Snippet Methods
    module_method_runner_string = ""
    # For each Module Method in @method_set
      # Build Either 
      # A) Solution Method
      # B) Readable Method 
    @method_set.each_with_index do |module_method,i|
      module_method_runner_string += module_method.build_method_runner(i+1)
      module_method_runner_string += "\n\n"
    end
    # RETURN STRING
    return module_method_runner_string.strip + "\n\n"
  end

  def build_solution_runners
    # Add ModuleX methods to wrap intended methods that shall run Solution Methods
    module_method_srunner_string = ""
    # For each Module Method in @method_set
      # Build Either 
      # A) Solution Method
      # B) Readable Method 
    @method_set.each_with_index do |module_method,i|
      module_method_srunner_string += module_method.build_solution_runner(i+1)
      module_method_srunner_string += "\n\n"
    end
    # RETURN STRING
    return module_method_srunner_string.strip + "\n\n"
  end

  def build_class_code
    class_string = ""
    accessor_string = ""

    # Build Class Accessor List
    if ((@class_variables !=nil ) && (!@class_variables.empty?))
      accessor_string += "attr_accessor"
      (1..@class_variables.length).each do |i|
        accessor_string += " :#{@class_variables[i-1]}"
        accessor_string += ', ' unless (i == @class_variables.length)
      end
      accessor_string += "\n\n"
    end
    # Build Class
    class_string = "class #{@class_name}\n"
    class_string += indent_each_line(accessor_string) if !accessor_string.empty?

    # Build Class Methods
    if ((@class_variables !=nil ) && (!@class_methods.empty?))
      class_string += indent_each_line(self.build_class_methods())
    end
    # Build Module Methods
    if !@method_set.empty?
      class_string += indent_each_line(self.build_module_methods())
      class_string += indent_each_line(self.build_module_methods(true))
      # class_string += indent_each_line(self.build_method_runners())
      # class_string += indent_each_line(self.build_solution_runners()) if !@solution_snippets.empty?
    end
    # Add Code Snippets
    compile_code_snippets()
    class_string += indent_each_line(self.build_snippet_methods())if !@user_code_snippets.empty?
    class_string += "end"
    return class_string.rstrip
  end

  def build_tests
    # Generate Code String for Class & Module Method Tests
  end

  def build_spec
    # Return Executable RSPEC File as String
    # CONCATENATE : 
    # build_class_code();
    # build_tests();
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
  DEBUG = true
  lesson_data = Testing::TestDataHandler.read_yaml_file(File.dirname(__FILE__)+'/tests/data/class_code_builder.yml');
  # TEST CODE (Lesson)
  # it 'should consolidate "module_codes" passed in to create single class code snippets and executable rspec.' do 
  #   expect(lesson_data["arguments"].class).to eq(Array)
  #   uut = ClassCodeBuilder.new(lesson_data["name"],lesson_data["arguments"])
  #   expect(uut.build_class_code).to eq(Testing::TestDataHandler.read_file_to_s('tests/data/class_code_1.rb'))
  # end

  def build_uut_base(data)
    # Initalize ClassCodeBuilder

    uut = ClassCodeBuilder.new(data[:name],data[:variables])

    # Create MethodCodeBuilder for 'ctor'
    ctor_method_builder = data[:class_methods]["initialize"][:builder]
    # 'add_method(ctor)' 
    uut.add_method(ctor_method_builder)

    # Create MethodCodeBuilder for 'run'
    run_method_builder = data[:class_methods]["run"][:builder]
    # 'add_method(run)' 

    uut.add_method(run_method_builder)   

    # Create MethodCodeBuilder for 'build_uut'
    uut_method_builder = data[:class_methods]["build_uut"][:builder]
    # 'add_method(run)' 
    uut.add_method(uut_method_builder)

    return uut
  end

  def build_uut_w_methods(data)
    uut = build_uut_base(data)
    data[:module_methods].each_value do |module_method| 
      uut.add_method(module_method[:builder])
    end
    return uut
  end

  # TEST CODE
  describe '#build_class_code' do 
    it 'should be able to create a basic class just after initialization' do
      uut = ClassCodeBuilder.new(lesson_data[:name],lesson_data[:variables])
      expect(uut.build_class_code).to eq(Testing::TestDataHandler.read_file_to_s('tests/data/class_code_empty.rb'))  
    end

    it 'should be able to build the initial base class plus module methods in base + solution form.' do 
      uut = build_uut_base(lesson_data)
      lesson_data[:module_methods].each_value do |module_method| 
        uut.add_method(module_method[:builder])
      end
      expected_string = Testing::TestDataHandler.read_file_to_s('tests/data/module_class_code.rb')
      generated_string = uut.build_class_code
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(uut.build_class_code,'./delete_test_class_module_method_code.rb') if DEBUG
      # TEST
      expect(generated_string).to eq(expected_string) 
    end 

    it 'should be able to build the initial base class plus module methods in base + solution, user-code forms.' do 
      uut = build_uut_w_methods(lesson_data)
      expected_string = Testing::TestDataHandler.read_file_to_s('tests/data/class_code_all_core_methods.rb')
      generated_string = uut.build_class_code
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(generated_string,'./delete_test_class_code_all_no_runners.rb') if DEBUG
      # TEST
      expect(generated_string).to eq(expected_string) 
    end 
  end

  describe '#build_class_methods' do 
    it 'should be able to provide the "init" class method in its working form.' do 
      # Initalize ClassCodeBuilder
      expect(lesson_data[:class_methods]["initialize"][:builder].arguments.class).to eq(Array)
      uut = ClassCodeBuilder.new(lesson_data[:name],lesson_data[:variables])
      # Create MethodCodeBuilder for 'ctor'
      ctor_method_builder = lesson_data[:class_methods]["initialize"][:builder]
      # 'add_method(ctor)' 
      uut.add_method(ctor_method_builder)
      
      # Create Expectation for Class Methods
      expect(uut.build_class_code).to eq(Testing::TestDataHandler.read_file_to_s('tests/data/class_code_init.rb')) 
    end

    it 'should be able to provide the "run" class method in its working form.' do 
      # Initalize ClassCodeBuilder
      uut = ClassCodeBuilder.new(lesson_data[:name],lesson_data[:variables])
      # Create MethodCodeBuilder for 'ctor'
      run_method_builder = lesson_data[:class_methods]["run"][:builder]
      # 'add_method(ctor)' 
      uut.add_method(run_method_builder)
      
      # Create Expectation for Class Methods
      expect(uut.build_class_code).to eq(Testing::TestDataHandler.read_file_to_s('tests/data/class_code_run.rb')) 
    end

    it 'should be able to provide the "build_uut" class method in its working form.' do 
      # Initalize ClassCodeBuilder
      uut = ClassCodeBuilder.new(lesson_data[:name],lesson_data[:variables])
      # Create MethodCodeBuilder for 'ctor'
      uut_method_builder = lesson_data[:class_methods]["build_uut"][:builder]
      # 'add_method(ctor)' 
      uut.add_method(uut_method_builder)
      
      # Create Expectation for Class Methods
      expect(uut.build_class_code).to eq(Testing::TestDataHandler.read_file_to_s('tests/data/class_code_uut.rb')) 
    end

    it 'should identify methods that have been generated specially for Class Execution, and generate code string' do
      # Initalize ClassCodeBuilder
      uut = ClassCodeBuilder.new(lesson_data[:name],lesson_data[:variables])

      # Create MethodCodeBuilder for 'ctor'
      ctor_method_builder = lesson_data[:class_methods]["initialize"][:builder]
      # 'add_method(ctor)' 
      uut.add_method(ctor_method_builder)

      # Create MethodCodeBuilder for 'run'
      run_method_builder = lesson_data[:class_methods]["run"][:builder]
      # 'add_method(run)' 

      uut.add_method(run_method_builder)   

      # Create MethodCodeBuilder for 'build_uut'
      uut_method_builder = lesson_data[:class_methods]["build_uut"][:builder]
      # 'add_method(run)' 
      uut.add_method(uut_method_builder)
      expected_string = Testing::TestDataHandler.read_file_to_s('tests/data/base_class_code.rb')
      generated_string = uut.build_class_code
      Testing::TestDataHandler.write_string_to_file(uut.build_class_code,'./delete_test_build_class_code.rb') if DEBUG

      # Create Expectation for Class Methods
      expect(generated_string).to eq(expected_string) 
    end
  end

  describe '#build_module_methods' do 
    it 'should be able to provide the "lesson" form of a module class method.' do 
      uut = build_uut_base(lesson_data)
      lesson_data[:module_methods].each_value do |module_method| 
        uut.add_method(module_method[:builder])
      end
      expected_string = Testing::TestDataHandler.read_file_to_s('tests/data/module_methods_base.rb')
      generated_string = uut.build_module_methods
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(uut.build_module_methods,'./delete_test_build_module_method_code.rb') if DEBUG
      # TEST
      expect(generated_string).to eq(expected_string) 
    end

    it 'should be able to provide the "solution" form of a module class method.' do
      uut = build_uut_base(lesson_data)
      lesson_data[:module_methods].each_value do |module_method| 
        uut.add_method(module_method[:builder])
      end
      expected_string = Testing::TestDataHandler.read_file_to_s('tests/data/module_methods_solution.rb')
      generated_string = uut.build_module_methods(true)
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(uut.build_module_methods(true),'./delete_test_build_module_method_s_code.rb') if DEBUG
      # TEST
      expect(generated_string).to eq(expected_string)
    end
  end

  describe '#build_snippet_methods' do
    it 'should be able to provide a consolidated listing of associated lesson session code snippets for module code' do 
      uut = build_uut_w_methods(lesson_data)
      expected_string = Testing::TestDataHandler.read_file_to_s('tests/data/user_method_snippets.rb')
      generated_string = uut.build_snippet_methods
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(generated_string,'./delete_test_build_user_code.rb') if DEBUG
      # TEST
      expect(generated_string).to eq(expected_string) 
    end

    # // TODO!
    # it 'should be able to compare snippet methods to determine some semblance of workability as a method.' do 
    # end
  end

  describe '#build_method_runners' do
    it 'should, knowing the number of methods, create runners for each of a class\'s module methods' do
      uut = build_uut_w_methods(lesson_data)
      expected_string = Testing::TestDataHandler.read_file_to_s('tests/data/class_method_runners.rb')
      generated_string = uut.build_method_runners
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(uut.build_method_runners(),'./delete_test_class_method_runners.rb') if DEBUG
      # TEST
      expect(generated_string).to eq(expected_string)
    end
  end

  describe '#build_solution_runners' do
    it 'should, knowing the number of methods, create solution runners for each of a class\'s module methods' do
      uut = build_uut_w_methods(lesson_data)
      expected_string = Testing::TestDataHandler.read_file_to_s('tests/data/class_method_srunners.rb')
      generated_string = uut.build_solution_runners
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(uut.build_solution_runners(),'./delete_test_class_method_srunners.rb') if DEBUG
      # TEST
      expect(generated_string).to eq(expected_string)
    end
  end

  describe '#build_tests' do 
    it "should loop through each method in the 'method_set' and build its test code." do
    end
  end

  describe '#build_spec' do
  end

  describe '#build_markup' do 
  end
end