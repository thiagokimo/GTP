module GTP
  class GP4
    FIELDS = %w(title subtitle artist album author copyright tab instruction notice triplet_feel)

    attr_accessor :file, :version, :offset, :lyrics, :tempo, :key, :octave

    attr_accessor *FIELDS

    attr_reader :file_path

    INTEGER_SIZE = 4

    def initialize(tab_path)
      @file = File.open(tab_path, "r")
      @offset = 31
    end

    def read_lyrics_string

      length = IO.binread(self.file, INTEGER_SIZE, self.offset).bytes.to_a[0].to_i

      increment_offset INTEGER_SIZE

      string = IO.binread(self.file, length, self.offset).gsub("\r\n", "\n")

      increment_offset length

      return string
    end

    def increment_offset delta
      self.offset = self.offset + delta
    end

    def read_integer

      result = IO.binread(self.file, INTEGER_SIZE, self.offset).bytes.to_a[0].to_i

      increment_offset INTEGER_SIZE

      return result
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

      increment_offset INTEGER_SIZE

      notice = ""

      for i in 1..lines-1
        notice << read_string << "\n"
      end

      notice << read_string

      self.notice = notice
    end

    def parse_triplet_feel
      self.triplet_feel = IO.binread(self.file, 1, self.offset).bytes.to_a[0].to_s
      increment_offset 1
    end

    def parse_lyrics
      track = read_integer
      self.lyrics = Array.new

      for i in 1..5
        bar = read_integer
        content = read_lyrics_string

        tuple = Hash.new
        tuple.store(bar, content)

        self.lyrics.push(tuple)
      end
    end

    def parse_tempo
      self.tempo = read_integer.to_i
    end

    def parse_key
      self.key = read_byte
    end

    def parse_octave
      self.octave = read_byte
    end

    def parse_midi_channels
      increment_offset 12 * 16 * 4 # TODO
    end

    def to_json

    end
  end
end