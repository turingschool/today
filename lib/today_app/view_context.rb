require 'yaml'
require 'ostruct' # le-sigh

class TodayApp
  class Page
    require 'helpers/view_helpers'
    include ViewHelpers

    attr_accessor :view, :source_file, :path, :data
    def initialize(view:, source_file:, path:, data:)
      self.source_file = source_file
      self.path        = path
      self.data        = data
      self.view        = view
    end

    def partial(path, locals={}, &block)
      view.partial path, locals_for(locals), &block
    end

    def wrap_layout(name, locals={}, &block)
      view.wrap_layout name, locals_for(locals), &block
    end

    private

    def locals_for(locals)
      {current_page: self}.merge(locals)
    end
  end

  class ViewContext
    attr_accessor :views_dir, :image_sprockets, :js_sprockets, :css_sprockets

    def initialize(views_dir, image_sprockets, js_sprockets, css_sprockets)
      self.views_dir       = views_dir
      self.image_sprockets = image_sprockets
      self.js_sprockets    = js_sprockets
      self.css_sprockets   = css_sprockets
    end

    def render(path, locals={}, &block)
      filename = find_file(path)
      return nil unless filename
      data, body = parse_file(filename)
      page   = Page.new(view: self, source_file: filename, path: path, data: data)
      locals = {current_page: page}.merge(locals)

      render = -> do
        tilt = Tilt.new(filename) { body }
        tilt.render(self, locals, &block)
      end

      if data.layout
        wrap_layout data.layout.intern, locals, &render
      else
        render.call
      end
    end

    def stylesheet_link_tag(filename)
      path = find_asset_path css_sprockets, filename
      %'<link href="#{path}" rel="stylesheet" type="text/css" />'
    end

    def javascript_include_tag(filename)
      path = find_asset_path js_sprockets, filename
      %'<script src="#{path}" type="text/javascript"></script>'
    end

    def find_asset_path(sprockets, filename)
      return filename if filename.start_with? '//'
      p asset_path: filename
      sprockets.each_logical_path.find { |p| p.start_with? filename }
    end

    def link_to(text, url)
      "<a href=#{url.inspect}>#{text}</a>"
    end

    def wrap_layout(name, locals={}, &block)
      render("layouts/#{name}", locals, &block)
    end

    def partial(path, locals={}, &block)
      dir  = File.dirname(path)
      base = File.basename(path)
      path = File.join dir, "_#{base}"
      render path, locals, &block
    end

    def find_file(path)
      path = File.join views_dir, path
      Dir.glob("#{path}*").first
    end

    def parse_file(filename)
      body     = File.read filename
      pieces   = body.split(/---\n+/, 3)
      body     = pieces.pop
      raw_data = pieces.pop || "{}"
      data     = YAML.load(raw_data)
      return OpenStruct.new(data), body
    end
  end
end
