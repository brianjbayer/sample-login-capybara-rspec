# frozen_string_literal: true

require 'rspec/core/rake_task'

desc 'run specs in parallel unless safari'
task :spec do
  if ENV['SPEC_BROWSER'] == 'safari'
    warn 'rake: running specs SEQUENTIALLY for safari'
    RSpec::Core::RakeTask.new(:spec)

  else
    warn 'rake: running specs in PARALLEL'
    ruby '-S parallel_rspec spec'
  end
end

task default: :spec
