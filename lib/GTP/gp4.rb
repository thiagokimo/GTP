module GTP
  class GP4

    attr_accessor :file,
                  :version,
                  :title,
                  :subtitle,
                  :artist,
                  :album,
                  :author,
                  :copyright,
                  :tab,
                  :instruction,
                  :notice,
                  :offset
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
      parse_title
      parse_subtitle
      parse_artist
      parse_album
      parse_author
      parse_copyright
      parse_tab
      parse_instruction
      parse_notice
    end

    def parse_title
      self.title = read_string
    end

    def parse_subtitle
      self.subtitle = read_string
    end

    def parse_artist
      self.artist = read_string
    end

    def parse_album
      self.album = read_string
    end

    def parse_author
      self.author = read_string
    end

    def parse_copyright
      self.copyright = read_string
    end

    def parse_tab
      self.tab = read_string
    end

    def parse_instruction
      self.instruction = read_string
    end

    def parse_notice
      lines = IO.binread(self.file, INTEGER_SIZE, self.offset).unpack("L")[0]

      self.offset = self.offset+INTEGER_SIZE

      notice = ""

      for i in 1..lines
        notice << read_string << "\n"
      end

      self.notice = notice
    end
  end
end