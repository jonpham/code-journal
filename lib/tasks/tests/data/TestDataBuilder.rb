load '../TestData.rb'

# HELPER METHODS
def extract_method_to_code_builder(module_code)
  t_method_hash = {
    method_name: module_code.method_name,
    arguments: module_code.arguments,
    return_type: module_code.return_type,
    source_code: module_code.source_code,
    code_id: module_code
  }
  t_method_code_builder = MethodCodeBuilder.new(t_method_hash)
  t_method_code_builder.set_solution = module_code.solution_code

  # Add Tests. 
  module_code.test_codes.each do |test_code|
    t_test_hash = {
      id: 0,
      input: test_code.expected_test_data,
      output: test_code.expected_return,
      description: test_code.test_description,
      assertion_type: test_code.assertion_type
    } 
    t_test_code_builder = TestCodeBuilder.new(test_code)
    t_method_code_builder.add_test(t_test_code_builder)
  end

  return t_method_code_builder
end

# Create Lesson Data Hash

lesson_data = Hash.new

# Push methods for each MethodCodeBuilders Required # (6x)
# initialize # run # build_uut
class_module = test_lesson.get_module_by_ordinal(0)

class_description = class_module.get_module_code(0)
lesson_data[:name] = class_description.method_name
lesson_data[:arguments] = class_description.arguments

# for each method in class_module
lesson_data[:class_methods] = Hash.new

class_module.module_codes.each do |module_code|
  # create MethodCodeBuilder
  if (module_code.module_ordinal != 0)
    t_code_builder = extract_method_to_code_builder(module_code)
    lesson_data[:class_methods][module_code.method_name] = {builder: t_code_builder}
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
    # create MethodCodeBuilder
    t_code_builder = extract_method_to_code_builder(module_code)
    lesson_data[:module_methods][module_code.method_name] = {builder: t_code_builder}
  end
end


# class_data = Testing::TestDataHandler.read_json_file('./class_code_builder.json')
# method_string = Testing::TestDataHandler.read_file_to_s('sandbox.rb')
# class_data["class_methods"][1].store("method_string",method_string)
# Testing::TestDataHandler.write_to_json(class_data,'./class_code_builder.json')


