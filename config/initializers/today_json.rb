require 'jsl/today_json'
require 'jsl/today_json/web_clients/net_http'

if Rails.env.development?
  host = 'http://localhost:3003'
else
  host = 'http://portal.turing.io'
end


web_client = Jsl::TodayJson::WebClients::NetHttp.new(host)
today_json = Jsl::TodayJson::Client.new(web_client)
Rails.configuration.today_json = today_json

# session = Rack::Test::Session.new(Rails.application)
# web_client = Jsl::TodayJson::WebClients::Rack.new session
# Client.new(web_client)
