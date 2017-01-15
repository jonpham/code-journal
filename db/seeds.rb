# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Drop All Data #
CodeSnippet.destroy_all
ModuleSession.destroy_all
LessonSession.destroy_all
User.destroy_all

TestCode.destroy_all
ModuleCode.destroy_all
LessonModule.destroy_all
Lesson.destroy_all
LessonCategory.destroy_all
#################
DEFAULT_PASSWORD='asdf1234'
User.create!({:email => "me@cj.com", :password => "qwer123", :password_confirmation => "qwer123", :admin => true })
User.create!({:email => "user@cj.com", :password => DEFAULT_PASSWORD, :password_confirmation => DEFAULT_PASSWORD, :admin => false })

admin_user = User.find_by(email: "me@cj.com")
test_user = User.find_by(email: "user@cj.com")

# Read Text from File / JSON ?
LessonCategory.create({name:'Development', 
  description:'Lessons that help to make this App.'})

## Sample Problem

# Lesson
  # t.string   "name"
  # t.text     "concept"
  # t.text     "purpose"
  # t.text     "description"
  # t.text     "example"
  # t.integer  "lesson_code_id"
  # t.integer  "test_code_id"
  # t.integer  "lesson_category_id"
sample_lesson = Lesson.new(
  {
    name:'Sample Lesson',
    concept:'Concept',
    purpose:'Purpose: Hello World!',
    description: 'Description',
    example: 'Example',
    lesson_category_id: LessonCategory.find_by(name:'Development').id,
    created_by: admin_user.id
  }
)

# Add LessonCreater Sessions
creator_lesson = LessonSession.create({
  lesson_id: sample_lesson.id ,
  user_id:    admin_user.id  
})

user_lesson = LessonSession.create({
  lesson_id: sample_lesson.id ,
  user_id:    test_user.id  
})

# Represents the Main Class Module (Module 0)
if sample_lesson.save
  sample_module = LessonModule.create(
    {
      lesson_id: sample_lesson.id,
      lesson_ordinal: 0,
      description: "Lesson #{sample_lesson.name}: Module 0 represents the Main Lesson Page"
    }
  )
end

# Lesson Class Code (ModuleCode)
class_method_hash = ModuleCode.create({
  lesson_module_id: sample_module.id,
  method_name: "SampleLesson",
  arguments: ['test'],
  return_type: 'void',
  source_code: 'attr_accessor :test',
  module_ordinal: 0
})

initialize_def_method = ModuleCode.create({
  lesson_module_id: sample_module.id,
  method_name: "initialize",
  arguments: nil,
  return_type: 'void',
  source_code: '@test = Array.new',
  module_ordinal: 1
})

uut_def_method= ModuleCode.create({
  lesson_module_id: sample_module.id,
  method_name: "build_uut",
  arguments: nil,
  return_type: 'object',
  source_code: 'return SampleLesson.new',
  module_ordinal: 2
})

run_def_method = ModuleCode.create({
  lesson_module_id: sample_module.id,
  method_name: "run",
  arguments: nil,
  return_type: 'int',
  source_code: 'puts say_hello\nputs say_words("hello","world!")\nputs say_string_array(["hello","world!"])\nreturn 0\n',
  module_ordinal: 3
})

run_def_test = TestCode.create({
  module_code_id: run_def_method.id,
  assertion_type: 'to eq', 
  expected_return: JSON.dump(0),
  expected_test_data: JSON.dump(nil),
  test_description: 'should consolidate the SampleLessons for "Hello World"'
})

## Say Hello Module 1

m1_say_hello = LessonModule.create({
    lesson_id: sample_lesson.id,
    lesson_ordinal: 1,
    description: "Lesson #{sample_lesson.name}: Module 1 represents the First Module Section 'hello_world'"
})

# Sessions
creator_module1 = ModuleSession.create({
  lesson_module_id: m1_say_hello.id,
  lession_session_id: creator_lesson.id  
})

user_module1 = ModuleSession.create({
  lesson_module_id: m1_say_hello.id,
  lession_session_id: user_lesson.id
})

# Module Data
say_hello_method = ModuleCode.create({
  lesson_module_id: m1_say_hello.id,
  method_name: 'say_hello',
  arguments: nil,
  return_type: 'string',
  source_code: '# Return Appropriate String',
  module_ordinal: 0
})

say_hello_solution = CodeSnippet.create({
  user_source_code: 'string = "This is me saying, hello world!"\nreturn string', 
  module_session_id: creator_module1.id
})

say_hello_attempt = CodeSnippet.create({
  user_source_code: "def say_hello\n  string = \"This is me saying, hello world!\"\n  return string\nend", 
  module_session_id: user_module1.id
})

say_hello_test = TestCode.create({
  module_code_id: say_hello_method.id,
  assertion_type: 'to eq', 
  expected_return: JSON.dump('This is me saying, hello world!'),
  expected_test_data: JSON.dump(nil),
  test_description: 'should return "This is me saying, hello world!"'
})

## Module 2 : Say Words 

m2_say_words = LessonModule.create({
    lesson_id: sample_lesson.id,
    lesson_ordinal: 2,
    description: "Lesson #{sample_lesson.name}: Module 2 represents the Second Module Section 'say_words'"
})

# Sessions
creator_module2 = ModuleSession.create({
  lesson_module_id: m2_say_words.id,
  lession_session_id: creator_lesson.id  
})

user_module2 = ModuleSession.create({
  lesson_module_id: m2_say_words.id,
  lession_session_id: user_lesson.id
})

# Module Data
say_words_method = ModuleCode.create({
  lesson_module_id: m2_say_words.id,
  method_name: 'say_words',
  arguments: ['word1','word2'],
  return_type: 'string',
  source_code: '# Return Appropriate String',
  module_ordinal: 0
})

say_words_solution = CodeSnippet.create({
  user_source_code: 'string = "This is me saying, #{word1} #{word2}"\nreturn string', 
  module_session_id: creator_module2.id
})

say_words_attempt = CodeSnippet.create({
  user_source_code: "def say_words(word1, word2)\n  string = \"This is me saying, \#{word1} \#{word2}\"\n  return string\nend", 
  module_session_id: user_module2.id
})

say_words_test = TestCode.create({
  module_code_id: say_words_method.id,
  assertion_type: 'to eq', 
  expected_return: JSON.dump('This is me saying, hello world!'),
  expected_test_data: JSON.dump(["hello","world!"]),
  test_description: 'should return "This is me saying, hello world!"'
})

## Module 3 : Say String Array
m3_say_array = LessonModule.create({
    lesson_id: sample_lesson.id,
    lesson_ordinal: 3,
    description: "Lesson #{sample_lesson.name}: Module 3 represents the Second Module Section 'say_array'"
})

# Sessions
creator_module3 = ModuleSession.create({
  lesson_module_id: m3_say_array.id,
  lession_session_id: creator_lesson.id  
})

user_module3 = ModuleSession.create({
  lesson_module_id: m3_say_array.id,
  lession_session_id: user_lesson.id
})

# Module Data
say_array_method = ModuleCode.create({
  lesson_module_id: m3_say_array.id,
  method_name: 'say_string_array',
  arguments: ['input_array'],
  return_type: 'string',
  source_code: '# Return Appropriate String',
  module_ordinal: 0
})

say_array_solution = CodeSnippet.create({
  user_source_code: 'string = "This is me saying, #{input_array[0]} #{input_array[1]}"\nreturn string',
  module_session_id: creator_module3.id
})

say_array_attempt = CodeSnippet.create({
  user_source_code: "def say_string_array(input_array)\n  string = \"This is me saying, \#{input_array[0]} \#{input_array[1]}\"\n  return string\nend",
  module_session_id: user_module3.id
})

say_array_test = TestCode.create({
  module_code_id: say_array_method.id,
  assertion_type: 'to eq', 
  expected_return: JSON.dump('This is me saying, hello world!'),
  expected_test_data: JSON.dump([["hello","world!"]]),
  test_description: 'should return "This is me saying, hello world!"'
})




