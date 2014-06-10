module ViewHelpers
  def format_date(date)
    date.strftime("%b %e, %Y")
  end

  def create_summary(text)
    #text[0..199] << "..."
    #text.split[0..100].join(" ")
    text.split("\n\n")[0..1].join("\n\n")
  end

  def nav_active(page)
    current_page.path == "#{page}.html" ? 'active' : nil
  end
end
