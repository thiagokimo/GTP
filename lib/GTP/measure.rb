module GTP
  class Measure
    FIELDS = %w(double_bar tonality marker_name marker_color num_alt_ending end_repeat begin_repeat denominator numerator)
    attr_accessor *FIELDS

    def initialize(args)
      FIELDS.each do |field|
        self.public_send "#{field}=", args[field.to_sym]
      end
    end

    def ==(o)
      o.class == self.class && o.state == state
    end

  protected
    def state
      info = []
      FIELDS.each do |f|
        info.push(f)
      end
    end
  end
end
