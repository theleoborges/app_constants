require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'rake/rdoctask'
require 'rspec/core/rake_task'
require 'jeweler/tasks'
require 'jeweler/specification'
require 'jeweler/rubygems_dot_org_tasks'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

desc 'Default: run unit tests.'
task :default => :spec

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "app_constants"
  gem.homepage = "http://github.com/leonardoborges/app_constants"
  gem.license = "MIT"
  gem.summary = %Q{A clean and simple way to manage your application's per-environment constants}
  gem.description = %Q{TODO: A clean and simple way to manage your application's per-environment constants}
  gem.email = "leonardoborges.rj@gmail.com"
  gem.authors = ["Leonardo Borges"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  #  gem.add_runtime_dependency 'jabber4r', '> 0.1'
  gem.add_development_dependency 'rspec'
end
Jeweler::RubygemsDotOrgTasks.new

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('test/**/*_spec.rb')
end

desc 'Generate documentation for the app_constants plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'AppConstants'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end





