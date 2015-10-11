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
      render params[:date], layout: 'outline'
    else
      redirect_to outlines_path
    end
  end

  private

  def has_outline?(date)
    File.exist? File.expand_path("../views/outlines/#{date}.markdown", __dir__)
  end
end
