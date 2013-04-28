# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reminders_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'reminders_client'
  spec.version       = RemindersClient::VERSION
  spec.authors       = ['Danny Olson']
  spec.email         = ['dbolson@gmail.com']
  spec.description   = %q{A Ruby interface to the Reminders API.}
  spec.summary       = %q{A Ruby interface to the Reminders API.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.13'
  spec.add_development_dependency 'webmock', '~> 1.11'

  spec.add_dependency 'rest-client', '~> 1.6.7'
end
