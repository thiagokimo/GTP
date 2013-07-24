require "GTP/version"
require "GTP/gp4"
require "GTP/measure"

module GTP
  def configure(&block)
    block.call self
  end
end
