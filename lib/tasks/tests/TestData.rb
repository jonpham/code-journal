require 'JSON'
require_relative 'TestClasses.rb'
require_relative '../RubyClassCodeBuilder.rb'

##### CREATE TEST DATA! #####
#Create Lesson
test_lesson = Testing::Lesson.new()

#Create First LessonModule for the Class Definition
class_module = Testing::LessonModule.new(0)

#Create Standard Class Methods.
class_def_method = Testing::MethodCode.new({
  method_name: "SampleLesson",
  arguments: ['test'],
  return_type: 'void',
  source_code: 'attr_accessor :test',
  module_ordinal: 0
})

initialize_def_method = Testing::MethodCode.new({
  method_name: "initialize",
  arguments: nil,
  return_type: 'void',
  source_code: '@test = Array.new',
  module_ordinal: 1
})

uut_def_method = Testing::MethodCode.new({
  method_name: "build_uut",
  arguments: nil,
  return_type: 'object',
  source_code: 'return SampleLesson.new',
  module_ordinal: 2
})

run_def_method = Testing::MethodCode.new({
  method_name: "run",
  arguments: nil,
  return_type: 'int',
  source_code: 'puts say_hello\nputs say_words("hello","world!")\nputs say_string_array(["hello","world!"])\nreturn 0\n',
  module_ordinal: 2
})

run_def_test = Testing::TestCode.new({
  assertion_type: 'to eq', 
  expected_return: JSON.dump(0),
  expected_test_data: JSON.dump(nil),
  test_description: 'should consolidate the SampleLessons for "Hello World"'
})
run_def_method.add_test_code(run_def_test);

# Insert Default Class Methods
class_module.add_method_code(class_def_method);
class_module.add_method_code(initialize_def_method);
class_module.add_method_code(run_def_method);
class_module.add_method_code(uut_def_method);

# Insert Class Module to Lesson
test_lesson.add_module(class_module);

### MODULES

## Say Hello Module 1
method_module_one = Testing::LessonModule.new(1)

say_hello_method = Testing::MethodCode.new({
  method_name: 'say_hello',
  arguments: nil,
  return_type: 'string',
  source_code: '# Return Appropriate String',
  module_ordinal: 0
})

solution_one = Testing::CodeSnippet.new('string = "This is me saying, hello world!"\nreturn string')
say_hello_method.add_solution(solution_one.source_code)
user_code_one = Testing::CodeSnippet.new("def say_hello\n  string = \"This is me saying, hello world!\"\n  return string\nend")
say_hello_method.add_user_code(user_code_one)

say_hello_test = Testing::TestCode.new({
  assertion_type: 'to eq', 
  expected_return: JSON.dump('This is me saying, hello world!'),
  expected_test_data: JSON.dump(nil),
  test_description: 'should return "This is me saying, hello world!"'
})

say_hello_method.add_test_code(say_hello_test);
method_module_one.add_method_code(say_hello_method);
test_lesson.add_module(method_module_one);

## Module 2 : Say Words 
test_set2=["hello","world!"]

method_module_two = Testing::LessonModule.new(2)

say_words_method = Testing::MethodCode.new({
  method_name: 'say_words',
  arguments: ['word1','word2'],
  return_type: 'string',
  source_code: '# Return Appropriate String',
  module_ordinal: 0
})

solution_two = Testing::CodeSnippet.new('string = "This is me saying, #{word1} #{word2}"\nreturn string')
say_words_method.add_solution(solution_two.source_code)
user_code_two = Testing::CodeSnippet.new("def say_words(word1, word2)\n  string = \"This is me saying, \#{word1} \#{word2}\"\n  return string\nend")
say_words_method.add_user_code(user_code_two)

say_words_test = Testing::TestCode.new({
  assertion_type: 'to eq', 
  expected_return: JSON.dump('This is me saying, hello world!'),
  expected_test_data: JSON.dump(test_set2),
  test_description: 'should return "This is me saying, hello world!"'
})

# Add to lesson
say_words_method.add_test_code(say_words_test);
method_module_two.add_method_code(say_words_method);
test_lesson.add_module(method_module_two);

## Module 3 : Say String Array
method_module_three = Testing::LessonModule.new(3)

say_array_method = Testing::MethodCode.new({
  method_name: 'say_string_array',
  arguments: ['input_array'],
  return_type: 'string',
  source_code: '# Return Appropriate String',
  module_ordinal: 0
})

solution_three = Testing::CodeSnippet.new('string = "This is me saying, #{input_array[0]} #{input_array[1]}"\nreturn string')
say_array_method.add_solution(solution_three.source_code)
user_code_three = Testing::CodeSnippet.new("def say_string_array(input_array)\n  string = \"This is me saying, \#{input_array[0]} \#{input_array[1]}\"\n  return string\nend")
say_array_method.add_user_code(user_code_three)
say_array_test = Testing::TestCode.new({
  assertion_type: 'to eq', 
  expected_return: JSON.dump('This is me saying, hello world!'),
  expected_test_data: JSON.dump([test_set2]),
  test_description: 'should return "This is me saying, hello world!"'
})

# Add to lesson
say_array_method.add_test_code(say_array_test);
method_module_three.add_method_code(say_array_method);
test_lesson.add_module(method_module_three);

### // FINISHED CREATING 'test_lesson' // ###

# HELPER METHODS
def extract_method_to_code_builder(module_code)

  t_method_hash = {
    method_name: module_code.method_name,
    arguments: module_code.arguments,
    return_type: module_code.return_type,
    source_code: module_code.source_code.gsub(/\\n/,"\n"),
    code_id: module_code
  }
  t_method_code_builder = RubyMethodCodeBuilder.new(t_method_hash)
  t_method_code_builder.set_solution(module_code.solution_code.gsub(/\\n/,"\n")) if module_code.solution_code != nil
  t_method_code_builder.set_user_code(module_code.user_code.source_code.gsub(/\\n/,"\n")) unless (module_code.user_code == nil || module_code.user_code.source_code.empty?)
  # Add Tests. 
  module_code.test_codes.each do |test_code|
    t_test_hash = {
      id: 0,
      input: test_code.expected_test_data,
      output: test_code.expected_return,
      description: test_code.test_description,
      assertion_type: test_code.assertion_type
    } 
    t_test_code_builder = RspecTestCodeBuilder.new(t_test_hash)
    t_method_code_builder.add_test(t_test_code_builder)
  end

  return {initial_hash: t_method_hash, builder: t_method_code_builder}
end

# Create Lesson Data Hash

lesson_data = Hash.new

# Push methods for each RubyMethodCodeBuilders Required # (6x)
# initialize # run # build_uut
class_module = test_lesson.get_module_by_ordinal(0)

class_description = class_module.get_module_code(0)
lesson_data[:name] = class_description.method_name
lesson_data[:variables] = class_description.arguments

# for each method in class_module
lesson_data[:class_methods] = Hash.new

class_module.module_codes.each do |module_code|
  # create RubyMethodCodeBuilder
  if (module_code.module_ordinal != 0)
    lesson_data[:class_methods][module_code.method_name] = extract_method_to_code_builder(module_code)
  end
end

# say_hello
# say_words(2args)
# say_words(1arg_array)
# Create Hash Object for ModuleMethods
class_method_modules = test_lesson.get_method_modules()
lesson_data[:module_methods] = Hash.new

class_method_modules.each do |methods_module|
  methods_module.module_codes.each do |module_code|
    # create RubyMethodCodeBuilder
    lesson_data[:module_methods][module_code.method_name] = extract_method_to_code_builder(module_code)
  end
end

# // UNCOMMENT TO WRITE OUT YML Data File.
Testing::TestDataHandler.write_to_yaml(lesson_data,'./data/class_code_builder.yml')
puts "'./data/class_code_builder.yml' WRITTEN OUT!"


# // Write Sample File to JSON.
# load './TestData.rb'
# class_data = Testing::TestDataHandler.read_json_file('./data/class_code_builder.json')
# method_string = Testing::TestDataHandler.read_file_to_s('sandbox.rb')
# class_data["class_methods"][1].store("method_string",method_string)













