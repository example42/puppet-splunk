# Install via
# bundle install --path vendor/gems

if RUBY_VERSION =~ /1.9/ # assuming you're running Ruby ~1.9
  Encoding.default_external = Encoding::ASCII
  Encoding.default_internal = Encoding::ASCII
  ENV['RUBYOPT'] = '-Kn'
end
#
# See http://bombasticmonkey.com/2011/11/04/test-your-puppet-modules-functions/
source 'https://rubygems.org'

gem 'puppet',       '= 3.1.1'
gem 'puppet-lint', :git => 'https://github.com/rodjek/puppet-lint.git'
gem 'rspec',        '< 3.0.0'
gem 'rspec-puppet', '>= 2.0.1'
gem 'rake',         '>= 0.9.2'
gem 'puppetlabs_spec_helper', '0.3.0'
