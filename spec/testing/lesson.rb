module Testing
  class Lesson
    attr_accessor :lesson_modules

    def initialize
      @lesson_modules = Array.new
    end

    def add_module(lesson_module)
      @lesson_modules.push(lesson_module)
    end

    def get_module_by_ordinal(desired_ordinal)
      @lesson_modules.each do | lesson_module |
        return lesson_module if (lesson_module.lesson_ordinal == desired_ordinal)
      end
      return nil
    end

    def get_method_modules
      method_modules = Array.new;
      @lesson_modules.each do | lesson_module |
        method_modules.push(lesson_module) if (lesson_module.lesson_ordinal != 0)
      end
      return method_modules;
    end
  end
end