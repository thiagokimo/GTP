# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'GTP/version'

Gem::Specification.new do |spec|
  spec.name          = "GTP"
  spec.version       = GTP::VERSION
  spec.authors       = ["Thiago Rocha"]
  spec.email         = ["kimo@kimo.io"]
  spec.description   = %q{A Guitar Pro file parser}
  spec.summary       = %q{It parses gtp files}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'pry'
end
