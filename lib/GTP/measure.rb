module GTP
  class Measure
    FIELDS = %w(double_bar tonality marker num_alt_ending end_repeat begin_repeat den_key num_key)
    attr_accessor *FIELDS
  end
end