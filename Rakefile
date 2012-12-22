#!/usr/bin/env rake
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

desc 'Run unit specs'
RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = 'spec/{*_spec.rb,leipzig/**/*_spec.rb}'
end

task :default => :spec
