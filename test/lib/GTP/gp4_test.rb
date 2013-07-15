require "test_helper"

module GTP
  describe GP4 do

    it "must read the file version" do
      parser = GP4.new "test/tabs/test.gp4"
      parser.parse_version

      parser.version.must_match %r/FICHIER GUITAR PRO v4./
    end

    it "must read the tablature info" do
      parser = GP4.new "test/tabs/test.gp4"
      parser.parse_info

      parser.title.must_equal "Title"
      parser.subtitle.must_equal "Subtitle"
      parser.artist.must_equal "Artist"
      parser.album.must_equal "Album"
      parser.author.must_equal "Author"
      parser.copyright.must_equal "Copyright"
      parser.tab.must_equal "Tab"
      parser.instruction.must_equal "Instruction"
      parser.notice.must_equal "N line 1\nN line 2\nN line 3\nN line 4"
      parser.triplet_feel.must_match "0"
    end

    describe "Lyrics" do
      parser = GP4.new "test/tabs/test.gp4"

      before do
        parser.parse_version
        parser.parse_info
      end

      it "must read the tablature lyrics" do
      
        parser.parse_lyrics

        parser.lyrics.must_equal [
                                   {1=>"1111\n1111\n1111\n1111"},
                                   {2=>"2222\n2222\n2222\n2222"},
                                   {1=>"3333\n3333\n3333"},
                                   {2=>"4444\n4444"},
                                   {1=>"5555"}
                                 ]
      end
    end

    describe "Other information" do
      parser = GP4.new "test/tabs/test.gp4"

      before do
        parser.parse_version
        parser.parse_info
        parser.parse_lyrics
      end

      it "about the piece" do
        parser.parse_tempo
        parser.parse_key
        parser.parse_octave
        parser.parse_midi_channels
        # parser.parse_number_of_measures
        # parser.parse_number_of_tracks

        parser.tempo.must_equal 120
        parser.key.must_equal 1
        parser.octave.must_equal 0
        # parser.midi_channels
      end
    end
    
    it "must read the tablature extra info" do

    end

    it "must read the tablature measures" do

    end

    it "must read the tablature tracks" do

    end

    it "must read the tablature song" do

    end

    it "must read the tablature chord diagrams" do

    end

    it "must increment the offset" do
      
    end
  end
end