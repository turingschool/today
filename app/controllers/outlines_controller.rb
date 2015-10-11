require 'markdown_handler'

class OutlinesController < ApplicationController
  def index
    outlines_dir     = File.join Rails.root, 'app', 'views', 'outlines'
    filename_pattern = '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].markdown'
    outline_names    = Dir.glob File.join(outlines_dir, filename_pattern)
    local_dates      = outline_names.map { |name| File.basename(name).chomp(".markdown") }
    remote_dates     = client.all_dates
    @outline_dates   = (local_dates | remote_dates).map { |date| Date.parse date }.sort
    render layout: 'content'
  end

  def today
    date = Date.current.strftime('%Y-%m-%d')
    redirect_to outline_path(date)
  end

  def show
    @title = params[:date]
    if has_outline? params[:date]
      return render params[:date], layout: 'outline'
    end

    day    = client.for(params[:date])
    if day.unscheduled?
      return redirect_to outlines_path
    end

    render inline: day.to_markdown, type: :markdown, layout: 'outline'
  end

  private

  def has_outline?(date)
    File.exist? File.expand_path("../views/outlines/#{date}.markdown", __dir__)
  end

  def client
    Rails.configuration.today_json
  end
end
