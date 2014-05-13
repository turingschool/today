begin
  ###
  # Compass
  ###

  # Change Compass configuration
  # compass_config do |config|
  #   config.output_style = :compact
  # end

  ###
  # Page options, layouts, aliases and proxies
  ###

  # Per-page layout changes:
  #
  # With no layout
  # page "/path/to/file.html", :layout => false
  #
  # With alternative layout
  # page "/path/to/file.html", :layout => :otherlayout
  #
  # A path which all have the same layout
  # with_layout :admin do
  #   page "/admin/*"
  # end

  # Proxy pages (http://middlemanapp.com/dynamic-pages/)
  # proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
  #  :which_fake_page => "Rendering a fake page with a local variable" }

  # Methods defined in the helpers block are available in templates
  helpers do
    # Implements the Paul Irish IE conditional comments HTML tag--in HAML.
    # http://paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/
    # Usage, instead of %html use:
    # != cc_html do
    def cc_html(options={}, &blk)
      attrs = options.map { |k, v| " #{h k}='#{h v}'" }.join('')
      [ "<!--[if lt IE 7 ]> <html#{attrs} class='ie lt-ie7 no-js'> <![endif]-->",
        "<!--[if IE 7 ]>    <html#{attrs} class='ie ie7 no-js'> <![endif]-->",
        "<!--[if IE 8 ]>    <html#{attrs} class='ie ie8 no-js'> <![endif]-->",
        "<!--[if IE 9 ]>    <html#{attrs} class='ie ie9 no-js'> <![endif]-->",
        "<!--[if (gt IE 9)|!(IE)]><!--> <html#{attrs} class='no-js'> <!--<![endif]-->",
        capture_haml(&blk).strip,
        "</html>"
      ].join("\n")
    end

    def h(str); Rack::Utils.escape_html(str); end

    def nav_active(page)
      current_page.path == "#{page}.html" ? 'active' : nil
    end
  end

  # Automatic image dimensions on image_tag helper
  # activate :automatic_image_sizes

  # Reload the browser automatically whenever files change
  # activate :livereload

  # Methods defined in the helpers block are available in templates
  # helpers do
  # end

  activate :directory_indexes
  set :build_dir, "tmp"

  set :css_dir, 'stylesheets'
  set :js_dir, 'javascripts'
  set :images_dir, 'images'

  # Build-specific configuration
  configure :build do
    # For example, change the Compass output style for deployment
    activate :minify_css

    # Minify Javascript on build
    activate :minify_javascript

    # Enable cache buster
    activate :asset_hash

    # Use relative URLs
    activate :relative_assets

    # Or use a different image path
    # set :http_prefix, "/Content/images/"
  end
rescue Exception
  puts "Compass I hate you"
end
