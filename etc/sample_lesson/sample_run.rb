require '../../lib/tasks/TestData.rb'
require 'awesome_print'
# Assume these exists in Database / Models.

#Lesson.LessonModules 
#LessonModuleOrdinal[0] => ModuleCode === ClassCode   ==> TestCode[0]
#LessonModuleOrdinal[1] => ModuleCode === MethodCode1 ==> TestCode[1]
#LessonModuleOrdinal[2] => ModuleCode === MethodCode2 ==> TestCode[2]
#LessonModuleOrdinal[3] => ModuleCode === MethodCode3 ==> TestCode[3]

# Lesson Page should show.

# Class Code with Methods as Markdown.
# Class Code Test as Markdown

# At any given time a RSPEC Needs to be able to be generated for the class with the Solutions / UserMethods

# Build Class Code with Empty Methods as Markdown.

# class_module = Lesson.LessonModules.where(LessonOrdinal==0);
class_module_code = test_lesson.get_module_by_ordinal(0).get_module_code(0);
# class_module.module_codes.where(ModuleOrdinal!=0);
class_methods = test_lesson.get_module_by_ordinal(0).method_code
class_methods.delete_if { |x| x.module_ordinal == 0 }

# Pass in Class Module Code (ClassName, attribute_accessors) as well as additional Method Module Codes for (run/initialize)
lesson_class_builder = ClassCodeBuilder.new(class_name,variables)
lesson_class_builder.set_run_method(run_code);
lesson_class_builder.set_ctor(ctor_code);
lesson_class_builder.set_uut(uut_code);
# Add Class Tests
class_test = TestCodeBuilder.new(test_args)
lesson_class_builder.add_test(class_test)


# Get Additional Modules
# lesson_modules = Lesson.LessonModules.where(LessonOrdinal!=0);
lesson_modules = test_lesson.get_method_modules;
# For Each Module, Loop Through Each Method and Add its Test to it. Then add the method to the class.

lesson_modules.each do |lesson_module|
  lesson_module.module_codes.each do |method_code|
    # Create New Method Builder.
    new_method = MethodCodeBuilder.new(method_args);
    method_code.test_codes.each do |test_code|
      #Create New TestCode Buildres.
      # Add to MethodBuilders
      new_method.add_test(test_code)
    end
    # Add method Builder to Class_builder.
    lesson_class_builder.add_method(new_method);
  end
end

code_runner = CodeRunner.new()
code_runner.run(lesson_class_builder.build_spec())

puts (ap code_runner.results)




