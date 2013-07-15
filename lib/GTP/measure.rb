module GTP
  class Measure
    FIELDS = %w(header double_bar tonality marker num_alt_ending end_repeat begin_repeat den_key num_key)
    attr_accessor *FIELDS

    def initialize(binary_data)
      @binary_data = binary_data

      setup
    end

    def setup
      
    end
  end
end