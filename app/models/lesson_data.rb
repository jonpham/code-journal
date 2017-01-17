# Ruby Class intended to bridge gap between Application Models and 
# RubyCodeBuilders / Runners

class LessonData 
  attr_accessor :data

  def initialize(lesson_id, user_id)
    @lesson = Lesson.find_by(id: lesson_id)
    @user_id = user_id
    # Get Creator Session 
    @user_session = LessonSession.where("lesson_id = ? AND user_id = ?",lesson_id,@user_id).limit(1).first
    # Get Lesson Session for User if != Creator
    @creator_session = LessonSession.where("lesson_id = ? AND user_id = ?",lesson_id,@lesson.created_by).limit(1).first
    # Load Base Lesson & Module Data
    @data = Hash.new

    # Get LessonModule for Class Data
    class_module = get_lesson_module_by_ordinal(@lesson.lesson_modules,0)
    # Get Module Codes from LessonModule
    class_description_code = get_module_code_by_ordinal(class_module.module_codes,0)
    # Extract Data from ClassModuleCode
  
    @data[:name] = class_description_code.method_name
    @data[:variables] = class_description_code.arguments

    # For Remaining Class Module Codes  
    class_module.module_codes.each do |module_code|
      # create RubyMethodCodeBuilder
      puts "I got to data line 29 : #{module_code}"
      if (module_code.module_ordinal != 0)
        @data[:class_methods][module_code.method_name] = extract_method_to_code_builder(module_code)
      end
    end

    # For Remaining Non-Class Lesson Modules
    class_method_modules = get_method_modules(@lesson)
    @data[:module_methods] = Hash.new

    class_method_modules.each do |methods_module|
      methods_module.module_codes.each do |module_code|
        # create RubyMethodCodeBuilder
        binding.pry
        @data[:module_methods][module_code.method_name] = extract_method_to_code_builder(module_code)
      end
    end

  end

  # def build_data
  #   get_class_descriptors
  # end

  def get_lesson_module_by_ordinal(lesson_modules,desired_ordinal)
    lesson_modules.each do | lesson_module |
      return lesson_module if (lesson_module.lesson_ordinal == desired_ordinal)
    end
    return nil
  end

  def get_module_code_by_ordinal(module_codes,desired_ordinal)
    module_codes.each do | module_code |
      return module_code if (module_code.module_ordinal == desired_ordinal)
    end
    return nil
  end

  # def get_class_descriptors
  # end

  def get_method_modules(lesson)
    # Get non Class Lesson Modules
    method_modules = Array.new;
    lesson.lesson_modules.each do | lesson_module |
      method_modules.push(lesson_module) if (lesson_module.lesson_ordinal != 0)
    end
    return method_modules;
  end

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
end
