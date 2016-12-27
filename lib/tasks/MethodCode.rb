require 'active_support'

class MethodCodeBuilder
  # include MardownConverter
  # include SourceBuilder
  
  def initialize(input_args)
    @method_name = input_args[:method_name]
    @num_args = input_args[:num_args]
    @return_type = input_args[:return_type]
    @source_code = input_args[:source_code]
    @code_id = input_args[:module_code_id]
  end

  def build_code(method_name=@method_name,num_args=@num_args,code=@source_code)
    method_string = "def #{method_name}"
    if num_args > 0 
      method_string += "( "
      (1..num_args).each do |i|
        method_string += "arg#{i}"
        method_string += ', ' unless (i == num_args)
      end
      method_string += ")"
    end
    method_string += "\n"
    method_string += indent_each_line(code)
    method_string += "end"
    return method_string.rstrip
  end

  def indent_each_line(text_block, num_indents=1)
    # For Each Line
    # Add \t*num_indents to front.
    indented_text_block =''
    text_block.each_line do |s| 
      indented_text_block += s.prepend('  '*num_indents)
    end
    return indented_text_block
  end

  def build_markup(code=build_code)
    return to_markdown(code).rstrip
  end

  def to_markdown(text)
    # raise Debug
    puts text
    markdown_text = "```ruby\n#{text}\n```"
    return markdown_text.rstrip
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
    num_args:  0,
    return_type: 'num',
    source_code: %Q(puts "Hello World!")
  }

  source1= <<~code
    text = "Hello World!"
    puts text
  code

  data_method_no_args_multiline = {
    method_name: "hellow",
    num_args:  0,
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
