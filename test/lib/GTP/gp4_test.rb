require "test_helper"

module GTP
  describe GP4 do

    let(:parser) { GP4.new "test/tabs/test.gp4" }
    let(:measure_params) {
      {
        numerator: rand(9),
        denominator: rand(9),
        begin_repeat: [true, false].sample,
        end_repeat: rand(9),
        num_alt_ending: rand(9),
        marker_name: nil,
        marker_color: nil,
        tonality: [0,1,2,-1].sample,
        double_bar: nil
      }
    }
    let(:channel_params) {
      {
        instrument: 24,
        volume: 1,
        balance: 1,
        chorus: 0,
        reverb: 0,
        phaser: 0,
        tremolo: 0,
        blank1: 0,
        blank2: 0
      }
    }
    before { parser.call }

    it "must read the file version" do
      parser.version.must_match %r/FICHIER GUITAR PRO v4./
    end

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

      channels = []

      before {
        4.times do
          channels.push(Channel.new(channel_params))
        end
      }

      it "about the piece" do
        parser.tempo.must_equal 120
        parser.key.must_equal 1
        parser.octave.must_equal 0
        parser.midi_channels.must_equal channels
        parser.num_measures.must_equal 2
        parser.num_tracks.must_equal 1
      end
    end

    describe "Serialization" do
      it "must serialize as json" do
        parser.to_json.must_equal "{\"score\":{\"info\":{\"version\":\"FICHIER GUITAR PRO v4.06\",\"title\":\"Title\",\"subtitle\":\"Subtitle\",\"artist\":\"Artist\",\"album\":\"Album\",\"author\":\"Author\",\"copyright\":\"Copyright\"},\"tempo\":120,\"key\":1,\"num_track\":1,\"num_measures\":2}}"
      end
    end

    describe "Measures" do

      first_measure_params = {
        numerator: 4,
        denominator: 4,
        begin_repeat: true,
        end_repeat: nil,
        num_alt_ending: nil,
        marker_name: nil,
        marker_color: nil,
        tonality: 1,
        double_bar: nil
      }

      second_measure_params = {
        numerator: 7,
        denominator: 8,
        begin_repeat: true,
        end_repeat: nil,
        num_alt_ending: nil,
        marker_name: nil,
        marker_color: nil,
        tonality: 1,
        double_bar: nil
      }

      first_measure = Measure.new(first_measure_params)
      second_measure = Measure.new(second_measure_params)

      it "must get the tab measures" do
        expected_measures = [first_measure,second_measure]

        parser.measures.must_equal expected_measures
      end
    end
  end
end
