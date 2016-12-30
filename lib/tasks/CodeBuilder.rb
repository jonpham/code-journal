require 'active_support'

class CodeBuilder
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
end
