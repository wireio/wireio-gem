# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wireio/version'

Gem::Specification.new do |spec|
  spec.name          = "wireio"
  spec.version       = WireIO::VERSION
  spec.authors       = ["Tabshora, Inc."]
  spec.email         = ["hello@getwire.io"]
  spec.description   = %q{Gem to consume WireIO rest api}
  spec.summary       = %q{WireIO rest api client}
  spec.homepage      = "https://github.com/wireio/wireio-gem"
  
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.0.4"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "rspec", "~> 2.13.0"
  
  spec.add_dependency "signature", "~> 0.1.7"
  spec.add_dependency "rest-client"
end
