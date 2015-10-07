require 'tilt'
require 'redcarpet'
require 'rack/request'
require 'rack/response'
require 'today_app/view_context'
require 'rack/builder'

require 'sprockets'
require 'uglifier'
require 'compass'

class TodayApp
  def self.for(root)
    Rack::Builder.new do
      image_sprockets = Sprockets::Environment.new
      image_sprockets.append_path File.join(root, 'assets', 'images')

      js_sprockets = Sprockets::Environment.new
      js_sprockets.append_path File.join(root, 'assets', 'javascripts')
      js_sprockets.js_compressor = :uglify

      css_sprockets = Sprockets::Environment.new
      css_sprockets.append_path File.join(root, 'assets', 'stylesheets')
      css_sprockets.append_path Compass::Frameworks::ALL.first.stylesheets_directory
      css_sprockets.css_compressor = :scss

      today_app = TodayApp.new(
        views_dir:       File.join(root, 'views'),
        image_sprockets: image_sprockets,
        js_sprockets:    js_sprockets,
        css_sprockets:   css_sprockets,
      )

      map('/stylesheets') { run css_sprockets }
      map('/javascripts') { run js_sprockets }
      map('/images')      { run image_sprockets }
      map('/')            { run today_app }
    end
  end

  attr_accessor :views_dir, :image_sprockets, :js_sprockets, :css_sprockets

  def initialize(views_dir:, image_sprockets:, js_sprockets:, css_sprockets:)
    self.views_dir       = views_dir
    self.image_sprockets = image_sprockets
    self.js_sprockets    = js_sprockets
    self.css_sprockets   = css_sprockets
  end

  def call(env)
    request  = Rack::Request.new env
    response = Rack::Response.new
    view     = ViewContext.new views_dir,
                               image_sprockets,
                               js_sprockets,
                               css_sprockets
    body     = view.render(request.path)

    if body
      response.body = [body]
    else
      response.status = 404
      response['Content-Type'] = Rack::Mime.mime_type('.txt')
      response.body = ['404 - page not found']
    end

    response.finish
  end
end
