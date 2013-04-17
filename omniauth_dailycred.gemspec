# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth_dailycred/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth_dailycred"
  spec.version       = OmniauthDailycred::VERSION
  spec.authors       = ["Hank Stoever"]
  spec.email         = ["hstove@gmail.com"]
  spec.description   = %q{Omniauth adapter for dailycred.com OAuth authentication.}
  spec.homepage      = "https://www.dailycred.com"
  spec.license       = "MIT"
  spec.add_dependency("omniauth")
  spec.add_dependency("omniauth-oauth2")

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
