require 'rouge/plugins/redcarpet'  # need to be required to use Rouge with Redcarpet

class MarkdownService
  attr_accessor :markdown

  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet # yep, that's it.
  end
  
  def initialize
    options = {
      # escape_html: true, # se to false to allow html, eg: <div>test</div>
      link_attributes: { rel: 'nofollow', target: "_blank" },
      hard_wrap: true,
      filter_html: true
    }

    renderer = HTML.new(options)

    extensions = {
      fenced_code_blocks: true,
      space_after_headers: true,
      autolink:           true,
      no_intra_emphasis: true,
      highlight: true,
      strikethrough: true,
      quote: true,
      no_images: false,
      superscript: true,
      footnotes: true,
      tables: true,
      with_toc_data: true,
      lax_spacing: true
    }
    @markdown = Redcarpet::Markdown.new(renderer, extensions)
  end

  def process_markdown(content)
    return @markdown.render(content).html_safe
  end
end