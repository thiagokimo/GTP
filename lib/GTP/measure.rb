module GTP
  class Measure
    FIELDS = %w(double_bar tonality marker_name marker_color num_alt_ending end_repeat begin_repeat denominator numerator)
    attr_accessor *FIELDS

    def ==(o)
      o.class == self.class && o.state == state
    end

  protected
    def state
      info = Array.new
      FIELDS.each do |f|
        info.push(numerator, denominator, begin_repeat, end_repeat, num_alt_ending, marker_name, marker_color, tonality, double_bar)
      end
    end
  end
end