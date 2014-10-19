$LOAD_PATH.unshift File.expand_path('../source', __dir__)
require 'helpers/outline_list_helpers'

describe 'outline list helpers' do
  class MockOutline
    def initialize(raw_date)
      @raw_date = raw_date
    end

    def data
      {layout: 'outline'}
    end

    def path
      "outlines/#@raw_date"
    end

    def ==(other)
      path == other.path
    end
  end

  def outline_on(date)
    MockOutline.new(date)
  end

  def outlines_between(start_day, end_day)
    (start_day..end_day).map { |n| outline_on('2014-10-%02d'%n) }
  end

  def outlines_by_cohort(outlines, cohorts)
    OutlinesByCohort.call(outlines, cohorts)
  end

  before do
    # sanity test
    expect(outline_on '2014-10-10').to eq outline_on('2014-10-10')
    expect(outlines_between 1, 3).to eq [ outline_on('2014-10-01'),
                                          outline_on('2014-10-02'),
                                          outline_on('2014-10-03'),
                                        ]
  end

  #     October 2014
  # Su Mo Tu We Th Fr Sa
  #           1  2  3  4
  #  5  6  7  8  9 10 11
  # 12 13 14 15 16 17 18
  # 19 20 21 22 23 24 25
  # 26 27 28 29 30 31

  it 'maps outlines to the cohorts that they belong to, grouped by week and sorted' do
    cohorts  = [['cohort1', Date.parse('2014-10-06')...Date.parse('2014-10-20')],
                ['cohort2', Date.parse('2014-10-20')...Date.parse('2014-11-01')]]
    outlines = outlines_between(6, 31)
    actual   = outlines_by_cohort outlines, cohorts
    expected = [['cohort1', [[Date.parse('2014-10-06'), outlines_between(6,  12)],
                             [Date.parse('2014-10-13'), outlines_between(13, 19)]]],
                ['cohort2', [[Date.parse('2014-10-20'), outlines_between(20, 26)],
                             [Date.parse('2014-10-27'), outlines_between(27, 31)]]]]
    expect(actual).to eq expected
  end

  it 'ignores cohorts that have no outlines falling on that day' do
    cohorts  = [['cohort1', Date.parse('2014-10-01')...Date.parse('2014-10-15')],
                ['cohort2', Date.parse('2014-10-15')...Date.parse('2014-11-01')]]
    outlines = outlines_between(15, 31)
    os_by_coh = outlines_by_cohort outlines, cohorts
    expect(os_by_coh.size).to eq 1
    expect(os_by_coh.first.first).to eq 'cohort2'
  end
end
