#!/usr/bin/env rake
require 'bundler'
require 'rake'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

desc 'Run unit specs'
RSpec::Core::RakeTask.new('spec') do |t|
  ENV['API_TYPE'] ||= 'mock'
  t.pattern = 'spec/{*_spec.rb,leipzig/**/*_spec.rb}'
end

task :default => :spec
