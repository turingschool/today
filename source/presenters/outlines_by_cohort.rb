require "helpers/outline_helpers"
require "helpers/view_helpers"
require 'time'

class OutlinesByCohort
  COHORTS = [
    ['1608', Date.parse('2016-08-15')...Date.parse('2016-09-24')],
    ['1606', Date.parse('2016-06-27')...Date.parse('2016-08-06')],
    ['1605', Date.parse('2016-05-09')...Date.parse('2016-06-18')],
    ['1603', Date.parse('2016-03-21')...Date.parse('2016-04-30')],
    ['1602', Date.parse('2016-02-01')...Date.parse('2016-03-12')],
    ['1511', Date.parse('2015-11-30')...Date.parse('2016-01-23')],
    ['1510', Date.parse('2015-10-12')...Date.parse('2015-11-21')],
    ['1508', Date.parse('2015-08-24')...Date.parse('2015-10-03')],
    ['1507', Date.parse('2015-07-06')...Date.parse('2015-08-15')],
    ['1505', Date.parse('2015-05-18')...Date.parse('2015-06-27')],
    ['1503', Date.parse('2015-03-30')...Date.parse('2015-05-09')],
    ['1502', Date.parse('2015-02-02')...Date.parse('2015-03-23')],
    ['1412', Date.parse('2014-12-15')...Date.parse('2015-02-02')],
    ['1410', Date.parse('2014-10-27')...Date.parse('2014-12-15')],
    ['1409', Date.parse('2014-09-08')...Date.parse('2014-10-27')],
    ['1407', Date.parse('2014-07-21')...Date.parse('2014-09-08')],
    ['1406', Date.parse('2014-06-03')...Date.parse('2014-07-21')]
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
