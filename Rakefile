require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint'
PuppetLint.configuration.send("disable_80chars")
PuppetLint.configuration.send('disable_class_parameter_defaults')

desc "Run rspec test with verbose output"
RSpec::Core::RakeTask.new(:spec_verbose) do |t|
  t.rspec_opts = ['--color', '-f d']
  t.pattern = 'spec/*/*_spec.rb'
end

task :default => [:spec_prep, :spec_verbose]
task :clean => [:spec_clean]