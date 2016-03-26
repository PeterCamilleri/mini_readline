# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mini_readline/version'

Gem::Specification.new do |spec|
  spec.name          = "mini_readline"
  spec.version       = MiniReadline::VERSION
  spec.authors       = ["Peter Camilleri"]
  spec.email         = ["peter.c.camilleri@gmail.com"]

  spec.summary       = "A simplified replacement for readline."
  spec.description   = "A gem for console command entry with line edit "+
                       "and history. This gem is like the standard readline " +
                       "gem except that it has been redesigned, simplified, " +
                       "and extensively cleaned up."

  spec.homepage      = "http://teuthida-technologies.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>=1.9.3'

  spec.add_development_dependency "minitest", ">= 5.7"
  spec.add_development_dependency "minitest_visible", ">= 0.1.1"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
