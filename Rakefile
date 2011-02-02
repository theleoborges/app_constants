require 'rake'
require 'rake/rdoctask'
require 'rubygems'
require 'spec/rake/spectask'

desc 'Default: run unit tests.'
task :default => :spec

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = Dir.glob('test/**/*_spec.rb')
end

desc 'Generate documentation for the app_constants plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'AppConstants'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
