class RubyMethodCodeBuilder < RubyCodeBuilder
  attr_reader :method_name, :source_code, :solution_code, :arguments, :user_code
  # include MardownConverter
  # include SourceBuilder

  IN_RAILS_APP = false
  
  def initialize(input_args)
    @method_name = input_args[:method_name]
    @arguments = input_args[:arguments] if input_args[:arguments].class == Array # Assumes Array 
    @arguments = Array.new if @arguments == nil
    @return_type = input_args[:return_type]
    @source_code = input_args[:source_code]
    @code_id = input_args[:module_code_id]
    @solution_code = ""
    @test_codes = Array.new
    @user_code = ""
  end

  def set_solution(code)
    @solution_code = code
  end

  def set_user_code(code)
    @user_code = code
  end

  def build_code(method_name="_#{@method_name}",args=@arguments,code=@source_code)
    method_string = "def #{method_name}"
    if ( args != nil && args.length > 0 )
      arg_string = "("
      (1..args.length).each do |i|
        arg_string += "#{@arguments[i-1]}"
        arg_string += ', ' unless (i == args.length)
      end
      arg_string += ")"
      method_string += arg_string.strip
    end
    method_string += "\n"
    method_string += indent_each_line(code)
    # Add New Line if @source_code does not end with \n
    method_string += "\n" unless code.end_with?("\n")
    method_string += "end"
    return method_string.rstrip
  end

  def build_solution(method_name="s_#{@method_name}",args=@arguments,code=@solution_code)
    return build_code(method_name,args,code)
  end

  def build_method_runner(method_number=0,solution_form=false)
    #Expand Method_number to Two Digits
    adjusted_method_number = method_number.to_s.rjust(2, padstr='0')
    method_prefix = ''
    method_name = 'method'
    
    if (solution_form)
      method_prefix = 's_'
      method_name = 'solution_method'
    end
    # Build Method Signature
    method_string = "def #{method_name + adjusted_method_number}(_args)"
    method_string += "\n"
    # Build Method Runner String
    method_runner = "return #{method_prefix + @method_name}"
    if ( @arguments != nil && @arguments.length > 0 )
      arg_string = "("
      (1..@arguments.length).each do |i|
        arg_string += "_args[#{i-1}]"
        arg_string += ', ' unless (i == @arguments.length)
      end
      arg_string += ")"
      method_runner += arg_string.strip
    end
    method_string += indent_each_line(method_runner)
    # Add New Line if @source_code does not end with \n
    method_string += "\n" unless method_string.end_with?("\n")
    method_string += "end"
    return method_string.rstrip
  end

  def build_solution_runner(method_number=0)
    build_method_runner(method_number,true)
  end

  def add_test(test_code_object)
    @test_codes.push(test_code_object)
  end

  def build_tests(module_id="00")
    module_num_string = module_id
    module_num_string = sprintf '%02d', module_id if module_id.class == Fixnum
    return "No Tests" if (@test_codes.empty?)
    use_case_string = "describe '#method#{module_num_string}' do\n" 
    test_case_strings = ""
    @test_codes.each do |test_code|
      test_case_strings.concat(test_code.build_test(module_num_string))
      test_case_strings = set_block_newlines(test_case_strings)
    end
    use_case_string += indent_each_line(test_case_strings).rstrip
    use_case_string += "\nend"
    return set_block_newlines(use_case_string.strip,0)
  end

  def build_spec
    if IN_RAILS_APP 
      spec_heading = "#require 'rspec'\n#require 'JSON'\n\n"
    else
      spec_heading = "require 'rspec'\nrequire 'JSON'\n\n"
    end
    spec_string="class TestMethod\n\n"
    spec_string.prepend(spec_heading) unless IN_RAILS_APP 
    spec_string.concat(set_block_newlines(indent_each_line(@user_code)))
    spec_string+=set_block_newlines(indent_each_line(self.build_method_runner()))
    spec_string+="end\n\ndef build_uut\n  return TestMethod.new()\nend\n\nRSpec.describe TestMethod do\n"
    spec_string+=indent_each_line(self.build_tests(),1)
    spec_string+="end"
    return spec_string
  end

  def run
    # Write Build Code to File. 
    return 0
  end
end
