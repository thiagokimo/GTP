module GTP
  class Reader

    attr_accessor :offset, :file
    INTEGER_SIZE = 4

    def initialize(file)
      @file = File.open(file, "r")
      @offset = 0
    end

    def read_next_chunk_with_offset(size, offset)
      increment_offset size
      IO.binread(self.file, size, offset)
    end

    def read_integer
      result = IO.binread(self.file, INTEGER_SIZE, self.offset).unpack('L').first
      increment_offset INTEGER_SIZE
      result
    end

    def increment_offset(delta)
      self.offset = self.offset + delta
    end

    def read_default_string(amount_to_read=1)
      skip_useless_bytes
      read_next_string amount_to_read
    end

    def read_string
      value = read_next_string
      skip_bytes value.length
      value
    end

    def read_first_string_and_unpack
      read_next_string.unpack("L")
    end

    def read_int_string
      read_next_string INTEGER_SIZE
    end

    def read_byte

      result = IO.binread(self.file, 1, self.offset).bytes.to_a

      increment_offset 1

      raise "Byte is greather than expected" if result.size > 1

      result.first.to_i
    end

    def skip_integer
      increment_offset INTEGER_SIZE
    end

    protected
    def skip_useless_bytes
      increment_offset INTEGER_SIZE
    end

    def skip_bytes(size)
      increment_offset 30-size
    end

    def read_next_string(amount_to_read=1)
      size = IO.binread(self.file, amount_to_read, self.offset).bytes.to_a.first.to_i
      increment_offset amount_to_read
      value = IO.binread(self.file, size, self.offset).strip
      increment_offset size
      value
    end
  end
end
