# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_idn/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-idn"
  spec.version       = RubyIdn::VERSION
  spec.authors       = ["satoshi hiraoka"]
  spec.email         = ["hiraokashogi@gmail.com"]

  spec.summary       = %q{wrapped idn command.}
  spec.description   = %q{be able to use idn commands at ruby.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
