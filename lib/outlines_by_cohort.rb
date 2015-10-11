require "view_helpers"
require 'time'

class OutlinesByCohort
  COHORTS = [
    ['1508', Date.parse('2015-08-24')...Date.parse('2015-10-03')],
    ['1507', Date.parse('2015-07-06')...Date.parse('2015-08-15')],
    ['1505', Date.parse('2015-05-18')...Date.parse('2015-06-27')],
    ['1503', Date.parse('2015-03-30')...Date.parse('2015-05-09')],
    ['1502', Date.parse('2015-02-02')...Date.parse('2015-03-23')],
    ['1412', Date.parse('2014-12-15')...Date.parse('2015-02-02')],
    ['1410', Date.parse('2014-10-27')...Date.parse('2014-12-15')],
    ['1409', Date.parse('2014-09-08')...Date.parse('2014-10-27')],
    ['1407', Date.parse('2014-07-21')...Date.parse('2014-09-08')],
    ['1406', Date.parse('2014-06-03')...Date.parse('2014-07-21')],
  ]

  def self.call(outline_dates, cohorts)
    cohorts.map { |cohort_name, date_range|
      [cohort_name,
       outlines_by_week(outlines_between(outline_dates, date_range))
      ]
    }.select { |cohort_name, outlines_by_week| outlines_by_week.any? }
  end

  private

  extend ViewHelpers

  def self.outlines_between(outline_dates, date_range)
    outline_dates.select do |date|
      date_range.cover? date
    end
  end

  def self.outlines_by_week(ouline_dates)
    ouline_dates.group_by { |date|        beginning_of_week date }
                .each     { |week, dates| dates.sort!            }
                .sort_by  { |week, dates| week                   }
  end
end
