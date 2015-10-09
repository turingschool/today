require 'markdown_handler'

class OutlinesController < ApplicationController
  def today
    date = Date.current.strftime('%Y-%m-%d')
    redirect_to outline_path(date)
  end

  def show
    @title = params[:date]
    if has_outline? params[:date]
      render params[:date], layout: 'outline'
    else
      # http://stackoverflow.com/questions/2385799/how-to-redirect-to-a-404-in-rails#answer-4983354
      render file: "#{Rails.root}/public/404",
             layout: false,
             status: :not_found
    end
  end

  private

  def has_outline?(date)
    File.exist? File.expand_path("../views/outlines/#{date}.markdown", __dir__)
  end
end
