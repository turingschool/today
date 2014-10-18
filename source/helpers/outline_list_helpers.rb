require 'date'
require 'pathname'

module OutlineListHelpers
  def outlines_by_week(resources)
    beginning_of_week = lambda do |date|
      days_since_monday = date.wday - 1
      date - days_since_monday
    end

    # an outline's path takes the form "outlines/yyyy-mm-dd.html"
    outline_date = lambda do |outline_path|
      Date.parse(
        Pathname.new(outline_path)
                .basename
                .sub_ext('')
                .to_s
      )
    end

    resources.select   { |resource| resource.data[:layout] == 'outline' }
             .map      { |outline|  [outline_date.call(outline.path), outline] }
             .group_by { |date, outline| beginning_of_week.call (date) }
             .each     { |date, dates_to_outlines| dates_to_outlines.sort_by! &:first }
             .sort_by  { |date, dates_to_outlines| date }
  end

  def format_date(date)
    date.strftime '%Y-%m-%d'
  end
end
