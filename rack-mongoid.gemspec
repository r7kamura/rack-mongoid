lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rack/mongoid/version"

Gem::Specification.new do |spec|
  spec.name          = "rack-mongoid"
  spec.version       = Rack::Mongoid::VERSION
  spec.authors       = ["Ryo Nakamura"]
  spec.email         = ["r7kamura@gmail.com"]
  spec.summary       = "A rack application working as an adapter for Mongoid"
  spec.homepage      = "https://github.com/r7kamura/rack-mongoid"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bson_ext", ">= 1.5.1"
  spec.add_dependency "mem", ">= 0.0.5"
  spec.add_dependency "mongoid", ">= 4.0.0.alpha2"
  spec.add_dependency "rack"
  spec.add_dependency "rack-multiplexer", ">= 0.0.8"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "pry", "0.9.12.6"
  spec.add_development_dependency "rack-test", "0.6.2"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "2.14.1"
  spec.add_development_dependency "rspec-json_matcher", "0.1.3"
end
