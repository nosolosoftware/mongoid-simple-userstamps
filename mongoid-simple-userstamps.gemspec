# coding: utf-8

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid-simple-userstamps/version'

Gem::Specification.new do |spec|
  spec.name          = 'mongoid-simple-userstamps'
  spec.version       = Mongoid::Userstamps::VERSION
  spec.authors       = ['Rafael Jurado']
  spec.email         = ['rjurado@nosolosoftware.es']
  spec.summary       = 'Simple way to add user stamps to your models.'
  spec.description   = 'Simple way to add user stamps to your models.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'mongoid', '>= 5.0.0'
end
