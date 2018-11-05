# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mini_readline/version'

Gem::Specification.new do |spec|
  spec.name          = "mini_readline"
  spec.version       = MiniReadline::VERSION
  spec.authors       = ["Peter Camilleri"]
  spec.email         = ["peter.c.camilleri@gmail.com"]

  spec.summary       = "Get console input with edit, history, and auto-complete."
  spec.description   = %{A gem, for console command entry with line edit and
                         history, inspired by the standard readline gem. Also
                         included are four sample auto-complete agents and the
                         irbm utility, which is irb + mini_readline and not an
                         Intermediate Range Ballistic Missile.
                        }.gsub(/\s+/, ' ').strip

  spec.homepage      = "https://github.com/PeterCamilleri/mini_readline"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>=2.0'

  spec.add_runtime_dependency     'mini_term', "~> 0.1.0"

  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency 'minitest', "~> 5.7"
  spec.add_development_dependency 'minitest_visible', "~> 0.1"
  spec.add_development_dependency 'rdoc', "~> 5.0"
  spec.add_development_dependency 'reek', "~> 4.5"

end
