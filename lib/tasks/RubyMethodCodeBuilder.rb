require_relative './RspecTestCodeBuilder.rb'

require_relative './tests/TestClasses.rb'
require 'rspec'


class RubyMethodCodeBuilder < RubyCodeBuilder
  attr_reader :method_name, :source_code, :solution_code, :arguments, :user_code
  # include MardownConverter
  # include SourceBuilder
  
  def initialize(input_args)
    @method_name = input_args[:method_name]
    @arguments = input_args[:arguments] if input_args[:arguments].class == Array # Assumes Array 
    @arguments = Array.new if @arguments == nil
    @return_type = input_args[:return_type]
    @source_code = input_args[:source_code]
    @code_id = input_args[:module_code_id]
    @solution_code = ""
    @test_codes = Array.new
    @user_code = ""
  end

  def set_solution(code)
    @solution_code = code
  end

  def set_user_code(code)
    @user_code = code
  end

  def build_code(method_name="_#{@method_name}",args=@arguments,code=@source_code)
    method_string = "def #{method_name}"
    if ( args != nil && args.length > 0 )
      arg_string = "("
      (1..args.length).each do |i|
        arg_string += "#{@arguments[i-1]}"
        arg_string += ', ' unless (i == args.length)
      end
      arg_string += ")"
      method_string += arg_string.strip
    end
    method_string += "\n"
    method_string += indent_each_line(code)
    # Add New Line if @source_code does not end with \n
    method_string += "\n" unless code.end_with?("\n")
    method_string += "end"
    return method_string.rstrip
  end

  def build_solution(method_name="s_#{@method_name}",args=@arguments,code=@solution_code)
    return build_code(method_name,args,code)
  end

  def build_method_runner(method_number=0,solution_form=false)
    #Expand Method_number to Two Digits
    adjusted_method_number = method_number.to_s.rjust(2, padstr='0')
    method_prefix = ''
    method_name = 'method'
    
    if (solution_form)
      method_prefix = 's_'
      method_name = 'solution_method'
    end
    # Build Method Signature
    method_string = "def #{method_name + adjusted_method_number}(_args)"
    method_string += "\n"
    # Build Method Runner String
    method_runner = "return #{method_prefix + @method_name}"
    if ( @arguments != nil && @arguments.length > 0 )
      arg_string = "("
      (1..@arguments.length).each do |i|
        arg_string += "_args[#{i-1}]"
        arg_string += ', ' unless (i == @arguments.length)
      end
      arg_string += ")"
      method_runner += arg_string.strip
    end
    method_string += indent_each_line(method_runner)
    # Add New Line if @source_code does not end with \n
    method_string += "\n" unless method_string.end_with?("\n")
    method_string += "end"
    return method_string.rstrip
  end

  def build_solution_runner(method_number=0)
    build_method_runner(method_number,true)
  end

  def add_test(test_code_object)
    @test_codes.push(test_code_object)
  end

  def build_tests(module_id="00")
    module_num_string = module_id
    module_num_string = sprintf '%02d', module_id if module_id.class == Fixnum
    return "No Tests" if (@test_codes.empty?)
    use_case_string = "describe '#method#{module_num_string}' do\n" 
    test_case_strings = ""
    @test_codes.each do |test_code|
      test_case_strings += test_code.build_test(module_num_string)
      test_case_strings = set_block_newlines(test_case_strings)
    end
    use_case_string += indent_each_line(test_case_strings).rstrip
    use_case_string += "\nend"
    return set_block_newlines(use_case_string.strip,0)
  end

  def build_spec
    spec_string="require 'rspec'\nrequire 'JSON'\n\nclass TestMethod\n\n"
    spec_string+=set_block_newlines(indent_each_line(@user_code))
    spec_string+=set_block_newlines(indent_each_line(self.build_method_runner()))
    spec_string+="end\n\ndef build_uut\n  return TestMethod.new()\nend\n\nRSpec.describe TestMethod do\n"
    spec_string+=indent_each_line(self.build_tests(),1)
    spec_string+="end"
    return spec_string
  end

  def run
    # Write Build Code to File. 
    return 0
  end
end

# Test Code
RSpec.describe RubyMethodCodeBuilder do 
  DEBUG = true
  # EXPECTED DATA
  lesson_data = Testing::TestDataHandler.read_yaml_file(File.dirname(__FILE__)+'/tests/data/class_code_builder.yml');

  data_method_no_args = {
    method_name: "hellow",
    arguments:  [],
    return_type: 'num',
    source_code: %Q(puts "Hello World!")
  }

  source1= <<~code
    text = "Hello World!"
    puts text
  code

  data_method_no_args_multiline = {
    method_name: "hellow",
    arguments:  [],
    return_type: 'num',
    source_code: source1
  }

  def build_say_words_uut(data)
    uut = RubyMethodCodeBuilder.new(data[:module_methods]["say_words"][:initial_hash])
      # Create RubyMethodCodeBuilder for 'say_words'

    solution_two = Testing::CodeSnippet.new('string = "This is me saying, #{word1} #{word2}"\nreturn string')
    uut.set_solution(solution_two.source_code.gsub(/\\n/,"\n"))
    user_code_two = Testing::CodeSnippet.new("def say_words(word1, word2)\n  string = \"This is me saying, \#{word1} \#{word2}\"\n  return string\nend")
    uut.set_user_code(user_code_two.source_code.gsub(/\\n/,"\n"))
    data[:module_methods]["say_words"][:initial_hash][:code_id].test_codes.each do |test_code|
      t_test_hash = {
        id: 0,
        input: test_code.expected_test_data,
        output: test_code.expected_return,
        description: test_code.test_description,
        assertion_type: test_code.assertion_type
      } 
      t_test_code_builder = RspecTestCodeBuilder.new(t_test_hash)
      uut.add_test(t_test_code_builder)
    end
    return uut
  end

  # TEST CODE (Lesson)
  it 'should consolidate "module_arguemnts" passed in to create single module code snippet & file @ /tmp/module_name_time.rb.' do 
    # Setup Expected Data
    uut = RubyMethodCodeBuilder.new(data_method_no_args_multiline)
    expect(uut.run).to eq(0)
  end

  # TEST CODE (Module)
  describe '#build_code' do 
    it 'create a proper string of the method that could be written to file or converted to markdown' do
      # Setup Expected Data
      exp_method_no_args_multiline = <<~code
        def _hellow
          text = "Hello World!"
          puts text
        end
      code
      uut = RubyMethodCodeBuilder.new(data_method_no_args_multiline)
      expect(uut.build_code).to eq(exp_method_no_args_multiline.rstrip)
    end

    it 'should be able to provide the "run" class method in its working form.' do 
      # Initalize ClassCodeBuilder
      uut = RubyMethodCodeBuilder.new(lesson_data[:class_methods]["run"][:initial_hash])
      # Create RubyMethodCodeBuilder for 'ctor'
      expect(uut.build_code('run')).to eq(Testing::TestDataHandler.read_file_to_s('tests/data/method_code_run.rb'));
    end
  end

  describe '#build_solution' do
    it 'should be able to provide the "say_words" class method in its solution form.' do 
      # Initalize ClassCodeBuilder
      uut = build_say_words_uut(lesson_data)
      # Create RubyMethodCodeBuilder for 'say_words'
      expect(uut.build_solution()).to eq(Testing::TestDataHandler.read_file_to_s('tests/data/module_method_say_words_s.rb'));
    end
  end

  describe '#build_method_runner' do 
    it 'should be able to provide the "say_words" class method in its solution form.' do 
      # Initalize ClassCodeBuilder
      uut = build_say_words_uut(lesson_data)
      # Create RubyMethodCodeBuilder for 'ctor'
      expect(uut.build_method_runner()).to eq(Testing::TestDataHandler.read_file_to_s('tests/data/module_method_runner_say_words.rb'));
    end
  end

  describe '#build_solution_runner' do 
    it 'should be able to provide the "say_words" class method in its solution form.' do 
      # Initalize ClassCodeBuilder
      uut = build_say_words_uut(lesson_data)
      # Create RubyMethodCodeBuilder for 'ctor'
      expect(uut.build_solution_runner(2)).to eq(Testing::TestDataHandler.read_file_to_s('tests/data/module_method_srunner_say_words.rb'));
    end
  end

  # TEST CODE (Markdown)  
  describe '#build_markup' do 
    it 'should be able to return string that will be recognized as MarkDown' do
      # Setup Expected Data
      exp_md_no_args_multiline = <<~code
        ```ruby
        def _hellow
          text = "Hello World!"
          puts text
        end
        ```
      code

      uut = RubyMethodCodeBuilder.new(data_method_no_args_multiline)
      expect(uut.build_markup).to eq(exp_md_no_args_multiline.rstrip)
    end
  end

  describe '#build_tests' do
    it 'should go through its @test_code Array variable and generate appropriate test code.' do
      uut = build_say_words_uut(lesson_data)
      expected_string = Testing::TestDataHandler.read_file_to_s('tests/data/module_method_t_say_words.rb')
      generated_string = uut.build_tests
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(uut.build_tests,'./delete_test_method_t_say_words.rb') if DEBUG
      # Create Expectation for MethodBuilder Methods
      expect(generated_string).to eq(expected_string) 
    end
  end

  describe '#build_spec' do 
    it 'should be able to ' do 
      uut = build_say_words_uut(lesson_data)
      expected_string = Testing::TestDataHandler.read_file_to_s('tests/data/module_spec_t_say_words.rb')
      generated_string = uut.build_spec
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(uut.build_spec,'./delete_module_spec_t_say_words.rb') if DEBUG
      # Create Expectation for MethodBuilder Methods
      expect(generated_string).to eq(expected_string) 
    end
  end
end
