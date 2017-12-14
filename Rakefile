require 'rspec/core/rake_task'

desc 'run specs in parallel unless safari'
task :spec do
  if ENV['SPEC_BROWSER'] != 'safari'
    STDERR.puts 'rake: running specs in parallel'
    ruby '-S parallel_rspec spec'
  else
    STDERR.puts 'rake: running specs in sequentially for safari'
    RSpec::Core::RakeTask.new(:spec)
  end
end

task default: :spec
