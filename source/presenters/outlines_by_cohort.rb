require "helpers/outline_helpers"
require "helpers/view_helpers"
require 'time'

class OutlinesByCohort
  COHORTS = [
    ['1502', Date.parse('2014-02-02')...Date.parse('2015-03-23')],
    ['1412', Date.parse('2014-12-15')...Date.parse('2015-02-02')],
    ['1410', Date.parse('2014-10-27')...Date.parse('2014-12-15')],
    ['1409', Date.parse('2014-09-08')...Date.parse('2014-10-27')],
    ['1407', Date.parse('2014-07-21')...Date.parse('2014-09-08')],
    ['1406', Date.parse('2014-06-03')...Date.parse('2014-07-21')],
  ]

  def self.call(outlines, cohorts)
    cohorts.map { |cohort_name, date_range|
      [cohort_name,
       outlines_by_week(outlines_between(outlines, date_range))
      ]
    }.select { |cohort_name, outlines_by_week| outlines_by_week.any? }
  end

  private

  extend OutlineHelpers
  extend ViewHelpers

  def self.outlines_between(outlines, date_range)
    outlines.select do |outline|
      date_range.cover? outline_date(outline.path)
    end
  end

  def self.outlines_by_week(outlines)
    outlines.map      { |outline|                 [outline_date(outline.path), outline] }
            .group_by { |date, outline|           beginning_of_week date                }
            .each     { |date, dates_to_outlines| dates_to_outlines.sort_by! &:first    }
            .sort_by  { |date, dates_to_outlines| date                                  }
            .map      { |date, dates_to_outlines| [date, dates_to_outlines.map(&:last)] }
  end
end
