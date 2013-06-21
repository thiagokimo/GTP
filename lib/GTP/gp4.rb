module GTP
  class GP4

    attr_accessor :file, :version
    attr_reader :file_path

    def initialize(tab_path)
      @file = File.open(tab_path, "r")
    end

    def parse_version

      size = IO.binread(self.file, 1).bytes.to_a[0].to_i

      self.version = IO.binread(self.file, size, 1).strip
    end
  end
end