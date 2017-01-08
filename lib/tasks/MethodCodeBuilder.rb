require 'rspec'

require_relative './TestCodeBuilder.rb'


class MethodCodeBuilder < CodeBuilder
  attr_reader :method_name, :source_code, :solution_code, :arguments
  # include MardownConverter
  # include SourceBuilder
  
  def initialize(input_args)
    @method_name = input_args[:method_name]
    @arguments = input_args[:arguments] if input_args[:arguments].class == Array # Assumes Array 
    @arguments = Array.new if @arguments == nil
    @return_type = input_args[:return_type]
    @source_code = input_args[:source_code]
    @code_id = input_args[:module_code_id]
    @solution_code = ""
    @test_code = Array.new
  end

  def set_solution(code)
    @solution_code = code
  end

  def build_code(method_name=@method_name,args=@arguments,code=@source_code)
    method_string = "def #{method_name}"
    if ( args != nil && args.length > 0 )
      method_string += "( "
      (1..args.length).each do |i|
        method_string += "arg#{i}"
        method_string += ', ' unless (i == args.length)
      end
      method_string += ")"
    end
    method_string += "\n"
    method_string += indent_each_line(code)
    method_string += "end"
    return method_string.rstrip
  end

  def build_solution(method_name=@method_name,args=@arguments,code=@solution_code)
    return build_code(method_name,args,code)
  end

  def add_test(test_code_object)
    @test_code.push(test_code_object)
  end

  def run
    # Write Build Code to File. 
    return 0
  end
end

# Test Code
RSpec.describe MethodCodeBuilder do 
  # EXPECTED DATA
  data_method_no_args = {
    method_name: "hellow",
    arguments:  [],
    return_type: 'num',
    source_code: %Q(puts "Hello World!")
  }

  source1= <<~code
    text = "Hello World!"
    puts text
  code

  data_method_no_args_multiline = {
    method_name: "hellow",
    arguments:  [],
    return_type: 'num',
    source_code: source1
  }

  # TEST CODE (Lesson)
  it 'should consolidate "module_arguemnts" passed in to create single module code snippet & file @ /tmp/module_name_time.rb.' do 
    # Setup Expected Data
    uut = MethodCodeBuilder.new(data_method_no_args_multiline)
    expect(uut.run).to eq(0)
  end

  # TEST CODE (Module)
  describe '#build_code' do 
    it 'create a proper string of the method that could be written to file or converted to markdown' do
      # Setup Expected Data
      exp_method_no_args_multiline = <<~code
        def hellow
          text = "Hello World!"
          puts text
        end
      code
      uut = MethodCodeBuilder.new(data_method_no_args_multiline)
      expect(uut.build_code).to eq(exp_method_no_args_multiline.rstrip)
    end
  end

  # TEST CODE (Module)  
  describe '#build_markup' do 
    it 'should be able to return string that will be recognized as MarkDown' do
      # Setup Expected Data
      exp_md_no_args_multiline = <<~code
        ```ruby
        def hellow
          text = "Hello World!"
          puts text
        end
        ```
      code

      uut = MethodCodeBuilder.new(data_method_no_args_multiline)
      expect(uut.build_markup).to eq(exp_md_no_args_multiline.rstrip)
    end
  end
end
