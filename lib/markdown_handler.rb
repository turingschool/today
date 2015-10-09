require 'redcarpet'

module MarkdownHandler
  def self.call(template)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML.new).render(template.source).inspect
  end
end

ActionView::Template.register_template_handler :markdown, MarkdownHandler
ActionView::Template.register_template_handler :md,       MarkdownHandler
