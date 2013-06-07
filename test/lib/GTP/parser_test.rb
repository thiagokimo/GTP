require "test_helper"

describe GTP::Parser do

  it "must read the file version" do
    parser = GTP::Parser.new "test/tabs/test.gp4"

    parser.parse_version.must_equal "FICHIER GUITAR PRO v4.00"
  end
end