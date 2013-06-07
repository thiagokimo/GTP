require "test_helper"

describe GTP do
  it "must have a version" do
    version = GTP::VERSION
    version.wont_be_nil
  end
end