require "GTP/version"
require "GTP/gp4"
require "GTP/measure"
require "GTP/io/reader"
require "GTP/channel"

module GTP
  def configure(&block)
    block.call self
  end
end
