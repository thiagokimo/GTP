module GTP
  class GP4
    FIELDS = %w(title subtitle artist album author copyright tab instruction notice triplet_feel)

    attr_accessor :file, :version, :offset

    attr_accessor *FIELDS

    attr_reader :file_path

    INTEGER_SIZE = 4

    def initialize(tab_path)
      @file = File.open(tab_path, "r")
      @offset = 31
    end

    def read_string

      self.offset = self.offset+INTEGER_SIZE

      length = IO.binread(self.file, 1, self.offset).bytes.to_a[0].to_i

      self.offset = self.offset + 1

      string = IO.binread(self.file, length, self.offset)

      self.offset = self.offset + length

      return string
    end

    def parse_version

      size = IO.binread(self.file, 1).bytes.to_a[0].to_i

      self.version = IO.binread(self.file, size, 1).strip
    end

    def parse_info
      FIELDS.each do |field|
        self.public_send "parse_#{field}"
      end
    end

    FIELDS.each do |field|
      define_method "parse_#{field}" do
        self.public_send "#{field}=", (self.public_send 'read_string')
      end
    end

    def parse_notice
      lines = IO.binread(self.file, INTEGER_SIZE, self.offset).unpack("L")[0]

      self.offset = self.offset+INTEGER_SIZE

      notice = ""

      for i in 1..lines-1
        notice << read_string << "\n"
      end

      notice << read_string

      self.notice = notice
    end

    def parse_triplet_feel
      self.triplet_feel = IO.binread(self.file, 1, self.offset).bytes.to_a[0].to_s
    end
  end
end