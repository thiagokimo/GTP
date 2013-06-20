require "test_helper"

describe GTP::GP4 do

  it "must read the file version" do
    parser = GTP::GP4.new "test/tabs/test.gp4"

    parser.parse_version.must_equal "FICHIER GUITAR PRO v4.06"
  end

  it "must read the tablature info" do
    
  end

  it "must read the tablature lyrics" do
    
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
end