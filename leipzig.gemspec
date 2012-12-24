# -*- encoding: utf-8 -*-
require File.expand_path('../lib/leipzig/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mario Behrendt"]
  gem.email         = ["info@mario-behrendt.de"]
  gem.description   = %q{Tiny client for API Leipzig}
  gem.summary       = %q{Tiny client for API Leipzig}
  gem.homepage      = "http://github.com/mbehrendt/leipzig.rb"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "leipzig"
  gem.require_paths = ["lib"]
  gem.version       = Leipzig::VERSION

  gem.add_dependency 'rest-client', '>= 1.6.7'

  gem.add_development_dependency 'rspec', '~> 2.12.0'
  gem.add_development_dependency 'rake', '~> 10.0.3'
  gem.add_development_dependency 'webmock', '~> 1.9.0'
end
