module GTP
  class Reader

    attr_accessor :offset, :file
    INTEGER_SIZE = 4

    def initialize(file)
      @file = File.open(file, "r")
      @offset = 31
    end

    def read_next_chunk delta

      result = IO.binread(self.file, delta).bytes.to_a

      raise "Byte is greather than expected" if result.size > 1

      string = result

      increment_offset delta

      string
    end

    def read_integer
      result = IO.binread(self.file, INTEGER_SIZE, self.offset).bytes.to_a[0].to_i
      increment_offset INTEGER_SIZE

      return result
    end

    def increment_offset delta
      self.offset = self.offset + delta
    end

    def read_string
      increment_offset INTEGER_SIZE

      length = IO.binread(self.file, 1, self.offset).bytes.to_a[0].to_i

      increment_offset 1

      string = IO.binread(self.file, length, self.offset)

      increment_offset length

      return string
    end

    def read_byte
      byte = IO.binread(self.file, 1, self.offset).bytes.to_a[0].to_i

      increment_offset 1

      return byte
    end

    def skip_integer
      increment_offset INTEGER_SIZE
    end
  end
end