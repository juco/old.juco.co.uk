#!/usr/bin/env rake

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task default: %w(spec)

Dir.glob('tasks/*.rb').each { |file| require File.expand_path file }
