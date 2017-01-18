# Ruby Class intended to bridge gap between Application Models and 
# RubyCodeBuilders / Runners

class LessonData 
  attr_accessor :name, :variables, :class_methods, :module_methods, :builder

  def initialize(lesson_id, user_id)
    @lesson = Lesson.find_by(id: lesson_id)
    @user_id = user_id
    # Get Creator Session 
    @user_session = LessonSession.where("lesson_id = ? AND user_id = ?",lesson_id,@user_id).limit(1).first
    # Get Lesson Session for User if != Creator
    @creator_session = LessonSession.where("lesson_id = ? AND user_id = ?",lesson_id,@lesson.created_by).limit(1).first

    # Load Base Lesson & Module Data
    # Get LessonModule for Class Data
    class_module = get_lesson_module_by_ordinal(@lesson.lesson_modules,0)
    # Get Module Codes from LessonModule
    class_description_code = get_module_code_by_ordinal(class_module.module_codes,0)
    # Extract Data from ClassModuleCode
  
    @name = class_description_code.method_name
    @variables = class_description_code.arguments
    @class_methods = Hash.new
    @module_methods = Hash.new

    # For Remaining Class Module Codes  
    class_module.module_codes.each do |module_code|
      # create RubyMethodCodeBuilder
      if (module_code.module_ordinal != 0)
        new_class_hash = extract_method_to_code_builder(module_code)
        @class_methods[module_code.method_name] = new_class_hash
      end
    end

    # For Remaining Non-Class Lesson Modules
    class_method_modules = get_method_modules(@lesson)
    class_method_modules.each do |methods_module|
      methods_module.module_codes.each do |module_code|
        # create RubyMethodCodeBuilder
        new_hash = extract_method_to_code_builder(module_code)
        @module_methods[module_code.method_name] = new_hash
      end
    end
  end

  def session_data
    session_data = {
      lesson_id: @lesson.id,
      user_session: @user_session,
      creator_session: @creator_session
    }
    return session_data
  end

  def build_lesson
    @builder = RubyClassCodeBuilder.new(@name,@variables)
    
    ## CLASS METHODS
    # Add method (ctor)
    @builder.add_method(@class_methods["initialize"][:builder])
    # Add MethodCodeBuilder for 'run'
    @builder.add_method(@class_methods["run"][:builder])  
    # Add MethodCodeBuilder for 'build_uut'
    @builder.add_method(@class_methods["build_uut"][:builder])

    @module_methods.each_value do |module_method| 
      @builder.add_method(module_method[:builder])
    end
    return @builder
  end

private
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
    user_code = get_user_code(module_code,t_method_code_builder)
    t_method_code_builder.set_user_code(user_code.gsub(/\\n/,"\n")) unless (user_code == nil || user_code.empty?)
    # Add Tests. 
    # byebug
    module_code.test_codes.each do |test_code|
      t_test_hash = {
        id: 0,
        input: test_code.expected_test_data,
        output: test_code.expected_return,
        description: test_code.description,
        assertion_type: test_code.assertion_type
      } 
      t_test_code_builder = RspecTestCodeBuilder.new(t_test_hash)
      t_method_code_builder.add_test(t_test_code_builder)
    end 
    return {initial_hash: t_method_hash, builder: t_method_code_builder}
  end

  def get_user_code(module_code,builder)
    # if User_ID == Creator_ID
    if (@user_id == @lesson.created_by)
      return builder.build_solution(module_code.method_name)
    else
      return module_code.user_code(@user_id)
    end
  end

end
