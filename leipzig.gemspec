# -*- encoding: utf-8 -*-
require File.expand_path('../lib/leipzig/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mario Behrendt"]
  gem.email         = ["info@mario-behrendt.de"]
  gem.description   = %q{Tiny client for API Leipzig}
  gem.summary       = %q{Tiny client for API Leipzig}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "leipzig"
  gem.require_paths = ["lib"]
  gem.version       = Leipzig::VERSION

  gem.add_dependency 'rest-client'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'
end
