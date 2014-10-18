require "helpers/outline_helpers"

module OutlineListHelpers
  include OutlineHelpers

  # sooo... this isn't tested.
  # Apparently testing isn't a thing for static sites -.-
  def outlines_by_month(outlines)
    outlines_by_week(outlines)
      .group_by { |week_start,  *| beginning_of_month week_start }
      .sort_by  { |month_start, *| month_start }
  end

  def outlines_by_week(outlines)
    outlines.map      { |outline|  [outline_date(outline.path), outline] }
            .group_by { |date, outline| beginning_of_week date }
            .each     { |date, dates_to_outlines| dates_to_outlines.sort_by! &:first }
            .sort_by  { |date, dates_to_outlines| date }
  end
end
