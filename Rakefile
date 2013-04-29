require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)

  task test: :spec
  task default: :spec
rescue LoadError => e
  desc 'Run specs'
  task :default do
    abort 'rake task is not available.'
  end
end
