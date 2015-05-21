# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clook/version'

Gem::Specification.new do |spec|
  spec.name          = "clook"
  spec.version       = Clook::VERSION
  spec.authors       = ["José Coelho"]
  spec.email         = ["jose.alberto.coelho@gmail.com"]

  spec.summary       = %q{Fetch configurations, made easy}
  spec.description   = %q{Fetch configurations from several backends with a common interface}
  spec.homepage      = "https://github.com/jacoelho/clook"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
