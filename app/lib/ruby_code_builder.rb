class RubyCodeBuilder
  def indent_each_line(text_block, num_indents=1)
    # For Each Line
    # Add \t*num_indents to front.
    indented_text_block =''
    text_block.each_line do |s| 
      indented_text_block += s.prepend('  '*num_indents)
    end
    return indented_text_block
  end

  def set_block_newlines(input_string,num_empty_lines=1)
    adjusted_string = input_string
    new_line_string = "\n"
    num_empty_lines.times do 
      new_line_string += "\n"
    end
    while (!adjusted_string.end_with?(new_line_string)) do
      adjusted_string += "\n" 
    end
    return adjusted_string
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
end
