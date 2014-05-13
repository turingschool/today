module ViewHelpers
  def format_date(date)
    date.strftime("%b %e, %Y")
  end
end
