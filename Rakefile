# frozen_string_literal: true

require 'bundler/audit/task'
require 'parallel_tests/tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

# Add Gem Tasks
Bundler::Audit::Task.new
RuboCop::RakeTask.new

# Custom Tasks
desc 'Run rubocop and bundler-audit'
task :checks do
  Rake::Task['rubocop'].invoke
  Rake::Task['bundle:audit'].invoke
end

# RSpec parallel task is the default
namespace :rspec do
  desc 'Run RSpec in parallel using parallel_tests'
  task :parallel do
    if ENV['BROWSER'] == 'safari'
      warn 'rake: running specs SEQUENTIALLY for safari'
      RSpec::Core::RakeTask.new(:spec)
      Rake::Task['spec'].invoke
    else
      Rake::Task['parallel:spec'].invoke
    end
  end
end

# Set the Default to running in parallel
task default: 'rspec:parallel'
