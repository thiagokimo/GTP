require "test_helper"

module GTP
  describe GP4 do

    it "must read the file version" do
      parser = GP4.new "test/tabs/test.gp4"
      parser.parse_version

      # p parser.version
      parser.version.must_match %r/FICHIER GUITAR PRO v4./
    end

    let(:parser) { GP4.new "test/tabs/test.gp4" }

    before { parser.call }

    describe 'tablature info' do
      it "must read the tablature info" do
        parser.title.must_equal "Title"
        parser.subtitle.must_equal "Subtitle"
        parser.artist.must_equal "Artist"
        parser.album.must_equal "Album"
        parser.author.must_equal "Author"
        parser.copyright.must_equal "Copyright"
        parser.tab.must_equal "Tab"
        parser.instruction.must_equal "Instruction"
        parser.notice.must_equal "N line 1\nN line 2\nN line 3\nN line 4\n"
        parser.triplet_feel.must_match "0"
      end
    end

    describe "Lyrics" do
      it "must read the tablature lyrics" do
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
      it "about the piece" do
        parser.parse_tempo
        parser.parse_key
        parser.parse_octave
        parser.parse_midi_channels # <----- PARSE ME PLEASE!!!
        parser.parse_number_of_measures
        parser.parse_number_of_tracks

        parser.tempo.must_equal 120
        parser.key.must_equal 1
        parser.octave.must_equal 0
        # parser.midi_channels
        parser.num_measures.must_equal 2
        parser.num_tracks.must_equal 1
      end
    end

    describe "Serialization" do
      it "must serialize as json" do
        parser.to_json.must_equal "{\"score\":{\"info\":{\"version\":\"FICHIER GUITAR PRO v4.06\",\"title\":\"Title\",\"subtitle\":\"Subtitle\",\"artist\":\"Artist\",\"album\":\"Album\",\"author\":\"Author\",\"copyright\":\"Copyright\"},\"tempo\":null,\"key\":null,\"num_track\":null,\"num_measures\":null}}"
      end
    end

    # describe "Measures" do
    #   first_measure = Measure.new
    #   second_measure = Measure.new

    #   before do
    #     parser.parse_version
    #     parser.parse_info
    #     parser.parse_lyrics
    #     parser.parse_tempo
    #     parser.parse_key
    #     parser.parse_octave
    #     parser.parse_midi_channels
    #     parser.parse_number_of_measures
    #     parser.parse_number_of_tracks

    #     first_measure.numerator = 4
    #     first_measure.denominator = 4
    #     first_measure.begin_repeat = true
    #     first_measure.end_repeat = nil
    #     first_measure.num_alt_ending = nil
    #     first_measure.marker_name = nil
    #     first_measure.marker_color = nil
    #     first_measure.tonality = 1
    #     first_measure.double_bar = nil

    #     second_measure.numerator = 7
    #     second_measure.denominator = 8
    #     second_measure.begin_repeat = nil
    #     second_measure.end_repeat = nil
    #     second_measure.num_alt_ending = nil
    #     second_measure.marker_name = nil
    #     second_measure.marker_color = nil
    #     second_measure.tonality = nil
    #     second_measure.double_bar = nil

    #   end

    #   it "must get the tab measures" do
    #     parser.parse_measures

    #     expected_measures = Array.new
    #     expected_measures.push(first_measure)
    #     expected_measures.push(second_measure)

    #     # require "pry"; binding.pry

    #     parser.measures.must_equal expected_measures
    #   end
    # end
  end
end
