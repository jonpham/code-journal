class RubyClassCodeBuilder < RubyCodeBuilder
  attr_accessor :method_set, :user_code_snippets, :class_tests, :solution_snippets, :class_methods

  IN_RAILS_APP = false

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
    @class_tests.push(test_builder)
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
      class_method_string = set_block_newlines(class_method_string)
    end
    return set_block_newlines(class_method_string.strip)
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
      module_method_string = set_block_newlines(module_method_string)
    end
    # RETURN STRING
    return set_block_newlines(module_method_string.strip)
  end

  def build_snippet_methods
    # Generate Code String for User / Solution Code Methods
    code_snippet_string = ""
    # For Each Code Snippet in @user_code_snippets
    self.compile_code_snippets();
    @user_code_snippets.each do |code_snippet|
      code_snippet_string += code_snippet
      code_snippet_string = set_block_newlines(code_snippet_string)
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
    # Build Readable Method 
    @method_set.each_with_index do |module_method,i|
      module_method_runner_string += module_method.build_method_runner(i+1)
      module_method_runner_string = set_block_newlines(module_method_runner_string)
    end
    # RETURN STRING
    return set_block_newlines(module_method_runner_string.strip)
  end

  def build_solution_runners
    # Add ModuleX methods to wrap intended methods that shall run Solution Methods
    module_method_srunner_string = ""
    # For each Module Method in @method_set
    # Build Solution Method
    @method_set.each_with_index do |module_method,i|
      module_method_srunner_string += module_method.build_solution_runner(i+1)
      module_method_srunner_string = set_block_newlines(module_method_srunner_string)
    end
    # RETURN STRING
    return set_block_newlines(module_method_srunner_string.strip)
  end

  def build_class_code(with_runners=false)
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
    class_string += indent_each_line(self.build_method_runners()) if (!@method_set.empty? && with_runners)
    class_string += indent_each_line(self.build_solution_runners()) if (!@method_set.empty? && with_runners)
    class_string += "end"
    return class_string.rstrip
  end

  def build_tests
    # Generate Code String for Class & Module Method Tests
    return "#No Tests" if @method_set.empty?
    test_method_strings = ""
    # For each Module Method in @method_set
    # Build Solution Method
    @method_set.each_with_index do |module_method,i|
      test_method_strings += module_method.build_tests(i+1)
      test_method_strings = set_block_newlines(test_method_strings)
    end
    # RETURN STRING
    return set_block_newlines(test_method_strings.strip,0)
  end

  def build_spec
    # Return Executable RSPEC File as String
    if IN_RAILS_APP 
      spec_heading = "#require 'rspec'\n#require 'JSON'\n\n"
    else
      spec_heading = "require 'rspec'\nrequire 'JSON'\n\n"
    end
    # CONCATENATE : 
    # build_class_code();
    spec_string = spec_heading
    spec_string.concat(set_block_newlines(build_class_code(true)))
    spec_string +="def build_uut\n  return #{@class_name}.build_uut()\nend\n\n"
    # build_tests();
    spec_string += "RSpec.describe #{@class_name} do\n"
    spec_string += indent_each_line(set_block_newlines(build_tests))
    spec_string += "end"
    return spec_string
  end

  def build_class_sample
    # Return Class as Markdown
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

    # Build Module Methods
    if !@method_set.empty?
      class_string += indent_each_line(self.build_module_methods())
    end

    class_string += "end"
    return class_string.rstrip
  end
end
