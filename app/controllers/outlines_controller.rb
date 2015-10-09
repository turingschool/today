class OutlinesController < ApplicationController
  def show
    render "#{params[:date]}.markdown"
  end
end
