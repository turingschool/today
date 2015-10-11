require 'markdown_handler'

class OutlinesController < ApplicationController
  def index
    render text: 'all outlines'
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

    client = Rails.configuration.today_json
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
end
