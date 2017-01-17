module Testing
  class LessonModule
    attr_accessor :module_codes, :lesson_ordinal
    
    def initialize(lesson_ordinal)
      @module_codes = Array.new
      @lesson_ordinal=lesson_ordinal
    end

    def add_method_code(method_code)
      @module_codes.push(method_code)
    end

    def get_module_code(desired_ordinal)
      @module_codes.each do | module_code |
        return module_code if (module_code.module_ordinal == desired_ordinal)
      end
      return nil
    end
  end
end