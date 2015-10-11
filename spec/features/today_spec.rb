# require 'today_app'
# require 'rack/test'
require 'rails_helper'
require 'jsl/today_json/test'

RSpec.feature 'Rendering outlines' do
  before do
    Rails.configuration.today_json = client
  end

  def client
    @client ||= Jsl::TodayJson::Mock::Client.new
  end

  describe '/outlines/:date' do
    it 'can render the existing markdown outlines' do
      page.visit '/outlines/2015-04-21'
      expect(page.status_code).to eq 200

      # renders markdown
      h2s = page.all('h2').map(&:text)
      expect(h2s).to include 'All'

      # for the expected file
      expect(page.body).to include 'TechHire will have a Hangout with Jeff at 1:30'

      # doesn't render frontmatter
      expect(page.body).to_not include 'layout: outline'

      # outline layout from haml
      h1s = page.all('h1').map(&:text)
      expect(h1s).to include '2015-04-21'

      # partial for the title
      expect(page.title.strip).to eq '2015-04-21'
    end

    it 'renders an outline from portal, if the outline DNE locally' do
      client.will_find_day 'date' => '9999-99-99',
                           'activities' => [
                             { 'activity_type' => 'daily_fact',
                               'content'       => 'the content',
                             }
                           ]

      page.visit '/outlines/9999-99-99'
      expect(page.current_path).to eq '/outlines/9999-99-99'
      paragraphs = page.all('p').map(&:text)
      expect(paragraphs).to include 'the content'
    end

    it 'redirects to /all when asked for an outline that DNE locally or in Portal' do
      page.visit '/outlines/9999-99-99'
      expect(page.current_path).to eq '/all'
    end

    it 'can render all the outlines' do
      outline_dir = File.expand_path '../../app/views/outlines', __dir__
      pattern     = File.join outline_dir, '*'
      Dir[pattern].each do |filename|
        date = File.basename(filename).chomp(".markdown")
        page.visit "/outlines/#{date}"
        expect(page.status_code).to eq 200
      end
    end
  end


  describe '/all' do
    def today_is(string_date)
      date = Date.parse string_date
      allow(Date).to receive(:today).and_return(date)
      allow(Date).to receive(:current).and_return(date)
    end

    it 'redirects from the root path to todays page' do
      today_is '2015-04-22'
      page.visit '/'
      expect(page.current_path).to eq '/outlines/2015-04-22'
    end

    # TODO: something about when there is no outline for the date
    #   (pull from portal, if it exists)
    it 'renders all the outlines here, combined with the oulines from portal' do
      skip
      # something about index.html.erb
    end
  end
end
