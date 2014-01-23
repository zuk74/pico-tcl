# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pico-tcl/version'

Gem::Specification.new do |spec|
  spec.name          = "pico-tcl"
  spec.version       = PicoTcl::VERSION
  spec.authors       = ["Shingo-Zukunashi"]
  spec.email         = ["shingo.zukunashi@gmail.com"]
  spec.description   = %q{small Tcl interpreter with Ruby.}
  spec.summary       = %q{small Tcl interpreter with Ruby.}
  spec.homepage      = "https://github.com/zuk74"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
