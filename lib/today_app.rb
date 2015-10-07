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
      sprockets = Sprockets::Environment.new
      sprockets.append_path File.join(root, 'assets')
      sprockets.append_path File.join(root, 'assets', 'images')
      sprockets.append_path Compass::Frameworks::ALL.first.stylesheets_directory
      sprockets.js_compressor  = :uglify
      sprockets.css_compressor = :scss

      today_app = TodayApp.new views_dir: File.join(root, 'views'),
                               sprockets: sprockets
      run today_app
    end
  end

  attr_accessor :views_dir, :sprockets

  def initialize(views_dir:, sprockets:)
    self.views_dir = views_dir
    self.sprockets = sprockets
  end

  def call(env)
    request  = Rack::Request.new env
    response = Rack::Response.new
    if %w[/images /javascripts /stylesheets].any? { |asset_type| request.path.start_with? asset_type }
      # need to find / render the assets here
      # require "pry"
      # binding.pry
    elsif body = ViewContext.new(views_dir, sprockets).render(request.path)
      response.body = [body]
    else
      response.status = 404
      response['Content-Type'] = Rack::Mime.mime_type('.txt')
      response.body = ['404 - page not found']
    end

    response.finish
  end
end
