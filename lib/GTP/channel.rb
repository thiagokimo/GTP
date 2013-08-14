module GTP
  class Channel
    FIELDS = %w(instrument volume balance chorus reverb phaser tremolo blank1 blank2)
    attr_accessor *FIELDS

    def initialize(options = {})
      self.instrument = options[:instrument] ||= 0
      self.volume = options[:volume] ||= 10
      self.balance = options[:balance] ||= 10
      self.chorus = options[:chorus] ||= 0
      self.reverb = options[:reverb] ||= 0
      self.phaser = options[:phaser] ||= 0
      self.tremolo = options[:tremolo] ||= 0
      self.blank1 = options[:blank1] ||= 0
      self.blank2 = options[:blank2] ||= 0
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
