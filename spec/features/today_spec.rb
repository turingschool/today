# require 'today_app'
# require 'rack/test'
require 'rails_helper'

# looks_like_a_date_to_me = /^\d\d\d\d-\d\d-\d\d$/
# web_client = Jsl::TodayJson::WebClients::NetHttp.new('http://localhost:3003')
# today_json = Jsl::TodayJson::Client.new(web_client)

RSpec.feature 'api spec' do
  before { skip }
  include Rack::Test::Methods

  def app
    described_class.for(root_dir)
  end

  def root_dir
    File.expand_path '..', __dir__
  end

  it 'can render the outlines' do
    response = get '/outlines/2015-04-21'
    expect(response.status).to eq 200

    # renders markdown
    expect(response.body).to include '<h2>All</h2>'

    # for the expected file
    expect(response.body).to include 'TechHire will have a Hangout with Jeff at 1:30'

    # doesn't render frontmatter
    expect(response.body).to_not include 'layout: outline'

    # outline layout from haml
    expect(response.body).to match /<h1>\s*2015-04-21\s*<\/h1>/m

    # partial for the title
    expect(response.body).to match /<title>\s*20150421\s*<\/title>/m

    # stylesheet / js link tags
    expect(response.body).to include %'<link href="stylesheets/application.css" rel="stylesheet" type="text/css" />'
    expect(response.body).to include %'<script src="//use.typekit.net/xxm2mvw.js" type="text/javascript"></script>'
  end

  it 'renders a 404 page when asked for an unknown path' do
    response = get '/outlines/9999-99-99'
    expect(response.status).to eq 404
    expect(response.body).to eq '404 - page not found'
  end

  it 'can render all.html.haml'
  # something about index.html.erb
end
