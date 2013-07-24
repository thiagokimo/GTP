module GTP
  class GP4
    FIELDS = %w(title subtitle artist album author copyright tab instruction notice triplet_feel)

    attr_accessor :file, :version, :offset, :lyrics, :tempo, :key, :octave, :num_measures, :num_tracks, :measures

    attr_accessor *FIELDS

    attr_reader :file_path

    INTEGER_SIZE = 4

    def initialize(tab_path)
      @reader = Reader.new tab_path
      @file = File.open(tab_path, "r")
    end

    def fix_header header

      counter = 0

      new_header = header.reverse

      while 8 > new_header.size
        new_header << "0"
      end

      return new_header
    end

    def parse_version

      size = @reader.read_byte

      self.version = @reader.read_next_chunk size

      # size = IO.binread(self.file, 1).bytes.to_a[0].to_i

      # self.version = IO.binread(self.file, size, 1).strip
    end

    def parse_info
      FIELDS.each do |field|
        self.public_send "parse_#{field}"
      end
    end

    FIELDS.each do |field|
      define_method "parse_#{field}" do
        self.public_send "#{field}=", @reader.read_string
      end
    end

    def parse_notice
      lines = IO.binread(self.file, INTEGER_SIZE, self.offset).unpack("L")[0]

      @reader.increment_offset INTEGER_SIZE

      notice = ""

      for i in 1..lines-1
        notice << @reader.read_string << "\n"
      end

      notice << @reader.read_string

      self.notice = notice
    end

    def parse_triplet_feel
      self.triplet_feel = IO.binread(self.file, 1, self.offset).bytes.to_a[0].to_s
      @reader.increment_offset 1
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
      self.key = read_integer
    end

    def parse_octave
      self.octave = read_byte
    end

    def parse_midi_channels
      @reader.increment_offset (12 * 16 * 4) # TODO
    end

    def parse_number_of_measures
      self.num_measures = read_integer.to_i
    end

    def parse_number_of_tracks
      self.num_tracks = read_integer
    end

    def parse_measures

      self.measures = Array.new

      for n in 1..self.num_measures do

        header = fix_header read_byte.to_s(2)
        numerator = nil
        denominator = nil
        begin_repeat = nil
        end_repeat = nil
        marker_name = nil
        marker_color = nil
        tonality = nil
        double_bar = nil

        if header[0] == "1"
          numerator = read_byte
        end

        if header[1] == "1"
          denominator = read_byte
        end

        if header[2] == "1"
          begin_repeat = true
        end

        if header[3] == "1"
          end_repeat = read_byte
        end

        if header[4] == "1"
          num_alt_ending = read_byte
        end

        if header[5] == "1"
          marker_name = @reader.read_string
          marker_color = read_integer
        end

        if header[6] == "1"
          tonality = read_byte
          @reader.increment_offset 1
        end

        if header[7] == "1"
          double_bar = true
        end

        measure = Measure.new
        measure.numerator = numerator
        measure.denominator = denominator
        measure.begin_repeat = begin_repeat
        measure.end_repeat = end_repeat
        measure.num_alt_ending = num_alt_ending
        measure.marker_name = marker_name
        measure.marker_color = marker_color
        measure.tonality = tonality
        measure.double_bar = double_bar

        self.measures.push(measure)
      end
    end

    def to_json

    end
  end
end
