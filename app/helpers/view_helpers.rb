module ViewHelpers
  extend self

  def format_date(date)
    date.strftime("%b %e, %Y")
  end

  def create_summary(text)
    #text[0..199] << "..."
    #text.split[0..100].join(" ")
    text.split("\n\n")[0..1].join("\n\n")
  end

  def nav_active(active, page)
    'active' if active == page
  end

  def yyyy_mm_dd_for(date)
    date.strftime '%Y-%m-%d'
  end

  def yyyy_mm_for(date)
    date.strftime '%Y-%m'
  end

  def weekday_for(date)
    date.strftime('%A') # e.g. "Wednesday"
  end

  def monthname_for(date)
    date.strftime('%B')
  end

  def beginning_of_week(date)
    days_since_monday = (date.wday - 1) % 7 # offset b/c week starts on Monday, not Sunday
    date - days_since_monday
  end

  def beginning_of_month(date)
    days_since_first_of_month = date.day - 1
    date - days_since_first_of_month
  end
end
