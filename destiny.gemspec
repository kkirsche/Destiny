# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'destiny/version'

Gem::Specification.new do |spec|
  spec.name          = 'destiny_api'
  spec.version       = Destiny::VERSION
  spec.authors       = ['Kevin Kirsche']
  spec.email         = ['kev.kirsche@gmail.com']
  spec.license       = 'Apache-2.0'

  spec.summary       = %q{Interact with Bungie's Destiny® API}
  spec.description   = %q{A gem for interacting with the Destiny REST API. API Key is required.}
  spec.homepage      = "https://github.com/kkirsche/Destiny"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'hurley', '~> 0'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'dotenv', '~> 2.0'
end
