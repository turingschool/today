require 'redcarpet'

module MarkdownHandler
  def self.erb
    @erb ||= ActionView::Template.registered_template_handler(:erb)
  end

  def self.call(template)
    compiled_source = erb.call(template)
    "Redcarpet::Markdown.new(Redcarpet::Render::HTML.new).render((#{compiled_source}));"
  end
end

ActionView::Template.register_template_handler :markdown, MarkdownHandler
ActionView::Template.register_template_handler :md,       MarkdownHandler
