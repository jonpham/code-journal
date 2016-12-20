module ApplicationHelper

  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  class HTMLrc < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    # def block_code(code, language,to='html')
    #   return Rouge.highlight(code, language || 'text', 'ruby');
    # end
  end

  def to_markdown(text)
    render_options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    renderer = HTMLrc.new(render_options)
    # raise Markdown
    extensions = {
      autolink:           true,
      fenced_code_blocks: true,
      lax_spacing:        true,
      no_intra_emphasis:  true,
      strikethrough:      true,
      superscript:        true,
      disable_indented_code_blocks: true
    }
    markdown = Redcarpet::Markdown.new(renderer, extensions);
    return markdown.render(text)
  end

  def rouge(text, language)
    formatter = Rouge::Formatters::HTML.new(css_class: 'highlight')
    lexer = Rouge::Lexer.find(language)
    # raise Rouging
    return formatter.format(lexer.lex(text))
  end

end
