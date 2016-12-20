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
      lax_spacing:        true,
      no_intra_emphasis:  true,
      strikethrough:      true,
      superscript:        true,
      disable_indented_code_blocks: false
    }
    return Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end
end
