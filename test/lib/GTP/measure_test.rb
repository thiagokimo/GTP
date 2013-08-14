require "test_helper"

module GTP
  describe Measure do
    it "must setup its attributes properly" do
      params = {
        numerator: 4,
        denominator: 4,
        begin_repeat: true,
        end_repeat: nil,
        num_alt_ending: nil,
        marker_name: nil,
        marker_color: nil,
        tonality: 1,
        double_bar: nil
      }

      measure = Measure.new(params)

      measure.numerator.must_equal 4
      measure.denominator.must_equal 4
      measure.begin_repeat.must_equal true
      measure.end_repeat.must_equal nil
      measure.num_alt_ending.must_equal nil
      measure.marker_name.must_equal nil
      measure.marker_color.must_equal nil
      measure.tonality.must_equal 1
      measure.double_bar.must_equal nil
    end
  end
end
