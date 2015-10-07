root = File.expand_path('.', __dir__)
$LOAD_PATH.unshift File.join(root, 'lib')
require 'today_app'
run TodayApp.for(root)


__END__
require "rack"
require "middleman/rack"
require "rack/contrib/try_static"
require "jsl/today_json"
require "jsl/today_json/web_clients/net_http"

# Build the static site when the app boots
# `bundle exec middleman build`

# Enable proper HEAD responses
use Rack::Head

# Attempt to serve static HTML files
use Rack::TryStatic,
    root: "tmp",
    urls: %w[/],
    try:  ['.html', 'index.html', '/index.html']

looks_like_a_date_to_me = /^\d\d\d\d-\d\d-\d\d$/
web_client = Jsl::TodayJson::WebClients::NetHttp.new('http://localhost:3003')
today_json = Jsl::TodayJson::Client.new(web_client)

run -> env {
  # refactor me :)
  building_page  = File.expand_path("../build/build_status.html", __FILE__)
  not_found_page = File.expand_path("../build/404.html", __FILE__)

  date = File.basename env['REQUEST_PATH']

  if date =~ looks_like_a_date_to_me
    day = today_json.for(date)
    todays_markdown = day.to_markdown if day
  else
    todays_markdown = nil
  end

  headers = { 'Content-Type' => 'text/html'}

  if todays_markdown
    require "pry"
    binding.pry
    html = ??
    [ 200, headers, [html]]
  elsif File.exist?(building_page)
    [ 200, headers, [File.read(building_page)] ]
  elsif File.exist?(not_found_page)
    [ 404, headers, [File.read(not_found_page)] ]
  else
    [ 404, headers, ['404 - page not found'] ]
  end
}
