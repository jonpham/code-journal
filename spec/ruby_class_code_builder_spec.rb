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


RSpec.describe RubyClassCodeBuilder do 
  DEBUG = false
  lesson_data = Testing::TestDataHandler.read_yaml_file(File.dirname(__FILE__)+'/testing/data/class_code_builder.yml');
  
  # TEST CODE (Lesson)
  # it 'should consolidate "module_codes" passed in to create single class code snippets and executable rspec.' do 
  #   expect(lesson_data["arguments"].class).to eq(Array)
  #   uut = RubyClassCodeBuilder.new(lesson_data["name"],lesson_data["arguments"])
  #   expect(uut.build_class_code).to eq(Testing::TestDataHandler.read_file_to_s('testing/data/class_code_1.rb'))
  # end

  def build_uut_base(data)
    # Initalize RubyClassCodeBuilder

    uut = RubyClassCodeBuilder.new(data[:name],data[:variables])

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
      uut = RubyClassCodeBuilder.new(lesson_data[:name],lesson_data[:variables])
      expect(uut.build_class_code).to eq(Testing::TestDataHandler.read_file_to_s('testing/data/class_code_empty.rb'))  
    end

    it 'should be able to build the initial base class plus module methods in base + solution form.' do 
      uut = build_uut_base(lesson_data)
      lesson_data[:module_methods].each_value do |module_method| 
        uut.add_method(module_method[:builder])
      end
      expected_string = Testing::TestDataHandler.read_file_to_s('testing/data/module_class_code.rb')
      generated_string = uut.build_class_code
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(uut.build_class_code,'./delete_test_class_module_method_code.rb') if DEBUG
      # TEST
      expect(generated_string).to eq(expected_string) 
    end 

    it 'should be able to build the initial base class plus module methods in base + solution, user-code forms.' do 
      uut = build_uut_w_methods(lesson_data)
      expected_string = Testing::TestDataHandler.read_file_to_s('testing/data/class_code_all_core_methods.rb')
      generated_string = uut.build_class_code
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(generated_string,'./delete_test_class_code_all_no_runners.rb') if DEBUG
      # TEST
      expect(generated_string).to eq(expected_string) 
    end 
  end

  describe '#build_class_methods' do 
    it 'should be able to provide the "init" class method in its working form.' do 
      # Initalize RubyClassCodeBuilder
      expect(lesson_data[:class_methods]["initialize"][:builder].arguments.class).to eq(Array)
      uut = RubyClassCodeBuilder.new(lesson_data[:name],lesson_data[:variables])
      # Create MethodCodeBuilder for 'ctor'
      ctor_method_builder = lesson_data[:class_methods]["initialize"][:builder]
      # 'add_method(ctor)' 
      uut.add_method(ctor_method_builder)
      
      # Create Expectation for Class Methods
      expect(uut.build_class_code).to eq(Testing::TestDataHandler.read_file_to_s('testing/data/class_code_init.rb')) 
    end

    it 'should be able to provide the "run" class method in its working form.' do 
      # Initalize RubyClassCodeBuilder
      uut = RubyClassCodeBuilder.new(lesson_data[:name],lesson_data[:variables])
      # Create MethodCodeBuilder for 'ctor'
      run_method_builder = lesson_data[:class_methods]["run"][:builder]
      # 'add_method(ctor)' 
      uut.add_method(run_method_builder)
      
      # Create Expectation for Class Methods
      expect(uut.build_class_code).to eq(Testing::TestDataHandler.read_file_to_s('testing/data/class_code_run.rb')) 
    end

    it 'should be able to provide the "build_uut" class method in its working form.' do 
      # Initalize RubyClassCodeBuilder
      uut = RubyClassCodeBuilder.new(lesson_data[:name],lesson_data[:variables])
      # Create MethodCodeBuilder for 'ctor'
      uut_method_builder = lesson_data[:class_methods]["build_uut"][:builder]
      # 'add_method(ctor)' 
      uut.add_method(uut_method_builder)
      
      # Create Expectation for Class Methods
      expect(uut.build_class_code).to eq(Testing::TestDataHandler.read_file_to_s('testing/data/class_code_uut.rb')) 
    end

    it 'should identify methods that have been generated specially for Class Execution, and generate code string' do
      # Initalize RubyClassCodeBuilder
      uut = RubyClassCodeBuilder.new(lesson_data[:name],lesson_data[:variables])

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
      expected_string = Testing::TestDataHandler.read_file_to_s('testing/data/base_class_code.rb')
      generated_string = uut.build_class_code
      Testing::TestDataHandler.write_string_to_file(uut.build_class_code,'./delete_test_build_class_code.rb') if DEBUG

      # Create Expectation for Class Methods
      expect(generated_string).to eq(expected_string) 
    end

    it 'should build all class methods into a usable class including runners.' do 
      uut = build_uut_w_methods(lesson_data)
      expected_string = Testing::TestDataHandler.read_file_to_s('testing/data/class_code_complete.rb')
      generated_string = uut.build_class_code(true)
      # DEBUG
      # binding.pry
      Testing::TestDataHandler.write_string_to_file(uut.build_class_code(true),'./delete_class_code_complete.rb') if DEBUG
      # TEST
      expect(generated_string).to eq(expected_string)
    end
  end

  describe '#build_module_methods' do 
    it 'should be able to provide the "lesson" form of a module class method.' do 
      uut = build_uut_base(lesson_data)
      lesson_data[:module_methods].each_value do |module_method| 
        uut.add_method(module_method[:builder])
      end
      expected_string = Testing::TestDataHandler.read_file_to_s('testing/data/module_methods_base.rb')
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
      expected_string = Testing::TestDataHandler.read_file_to_s('testing/data/module_methods_solution.rb')
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
      expected_string = Testing::TestDataHandler.read_file_to_s('testing/data/user_method_snippets.rb')
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
      expected_string = Testing::TestDataHandler.read_file_to_s('testing/data/class_method_runners.rb')
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
      expected_string = Testing::TestDataHandler.read_file_to_s('testing/data/class_method_srunners.rb')
      generated_string = uut.build_solution_runners
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(uut.build_solution_runners(),'./delete_test_class_method_srunners.rb') if DEBUG
      # TEST
      expect(generated_string).to eq(expected_string)
    end
  end

  describe '#build_tests' do 
    it "should loop through each method in the 'method_set' and build its test code." do
      uut = build_uut_w_methods(lesson_data)
      expected_string = Testing::TestDataHandler.read_file_to_s('testing/data/class_method_tests.rb')
      generated_string = uut.build_tests
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(uut.build_tests(),'./delete_class_method_tests.rb') if DEBUG
      # TEST
      expect(generated_string).to eq(expected_string)
    end
  end

  describe '#build_spec' do
    it "should compile all class methods to create a Runnable Class RSpec." do
      uut = build_uut_w_methods(lesson_data)
      expected_string = Testing::TestDataHandler.read_file_to_s('testing/data/class_spec_code.rb')
      generated_string = uut.build_spec
      # DEBUG
      Testing::TestDataHandler.write_string_to_file(uut.build_spec(),'./delete_class_spec_code.rb') if DEBUG
      # TEST
      expect(generated_string).to eq(expected_string)
    end
  end

  describe '#build_markup' do 
  end
end