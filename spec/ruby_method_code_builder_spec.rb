require_relative '../app/lib/ruby_code_builder.rb'
require_relative '../app/lib/ruby_class_code_builder.rb'
require_relative '../app/lib/ruby_method_code_builder.rb'
require_relative '../app/lib/rspec_test_code_builder.rb'
require_relative './testing/code_snippet.rb'
require_relative './testing/lesson.rb'
require_relative './testing/lesson_module.rb'
require_relative './testing/method_code.rb'
require_relative './testing/test_code.rb'
require_relative './testing/test_data_handler.rb'

# Test Code
RSpec.describe RubyMethodCodeBuilder do 
  DEBUG = false
  # EXPECTED DATA
  lesson_data = Testing::TestDataHandler.read_yaml_file(File.dirname(__FILE__)+'/testing/data/class_code_builder.yml');

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
      expect(uut.build_code('run')).to eq(Testing::TestDataHandler.read_file_to_s('testing/data/method_code_run.rb'));
    end
  end

  describe '#build_solution' do
    it 'should be able to provide the "say_words" class method in its solution form.' do 
      # Initalize ClassCodeBuilder
      uut = build_say_words_uut(lesson_data)
      # Create RubyMethodCodeBuilder for 'say_words'
      expect(uut.build_solution()).to eq(Testing::TestDataHandler.read_file_to_s('testing/data/module_method_say_words_s.rb'));
    end
  end

  describe '#build_method_runner' do 
    it 'should be able to provide the "say_words" class method in its solution form.' do 
      # Initalize ClassCodeBuilder
      uut = build_say_words_uut(lesson_data)
      # Create RubyMethodCodeBuilder for 'ctor'
      expect(uut.build_method_runner()).to eq(Testing::TestDataHandler.read_file_to_s('testing/data/module_method_runner_say_words.rb'));
    end
  end

  describe '#build_solution_runner' do 
    it 'should be able to provide the "say_words" class method in its solution form.' do 
      # Initalize ClassCodeBuilder
      uut = build_say_words_uut(lesson_data)
      # Create RubyMethodCodeBuilder for 'ctor'
      expect(uut.build_solution_runner(2)).to eq(Testing::TestDataHandler.read_file_to_s('testing/data/module_method_srunner_say_words.rb'));
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
      expected_string = Testing::TestDataHandler.read_file_to_s('testing/data/module_method_t_say_words.rb')
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
      expected_string = Testing::TestDataHandler.read_file_to_s('testing/data/module_spec_t_say_words.rb')
      generated_string = uut.build_spec
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(uut.build_spec,'./delete_module_spec_t_say_words.rb') if DEBUG
      # Create Expectation for MethodBuilder Methods
      expect(generated_string).to eq(expected_string) 
    end
  end
end
