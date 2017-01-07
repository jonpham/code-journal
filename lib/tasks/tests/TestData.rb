require 'JSON'
require_relative 'TestClasses.rb'

##### CREATE TEST DATA! #####
#Create Lesson
test_lesson = Testing::Lesson.new()

#Create First LessonModule for the Class Definition
class_module = Testing::LessonModule.new(0)

#Create Standard Class Methods.
class_def_method = Testing::MethodCode.new({
  method_name: "SampleLesson",
  arguments: nil,
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

run_def_method = Testing::MethodCode.new({
  method_name: "run",
  arguments: nil,
  return_type: 'int',
  source_code: 'puts say_hello\nputs say_words("hello","world!")\nputs say_string_array(["hello","world!"])',
  module_ordinal: 2
})

run_def_test = Testing::TestCode.new({
  assertion_type: 'eq', 
  expected_return: 0,
  expected_test_data: JSON.dump(nil),
  test_description: 'should consolidate the SampleLessons for "Hello World"'
})
run_def_method.add_test_code(run_def_test);

uut_def_method = Testing::MethodCode.new({
  method_name: "build_uut",
  arguments: nil,
  return_type: 'object',
  source_code: 'return SampleLesson.new',
  module_ordinal: 2
})

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

say_hello_test = Testing::TestCode.new({
  assertion_type: 'eq', 
  expected_return: 'This is me saying, hello world!',
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

say_words_test = Testing::TestCode.new({
  assertion_type: 'eq', 
  expected_return: 'This is me saying, hello world!',
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

say_array_test = Testing::TestCode.new({
  assertion_type: 'eq', 
  expected_return: 'This is me saying, hello world!',
  expected_test_data: JSON.dump(test_set2),
  test_description: 'should return "This is me saying, hello world!"'
})

# Add to lesson
say_array_method.add_test_code(say_array_test);
method_module_three.add_method_code(say_array_method);
test_lesson.add_module(method_module_three);














