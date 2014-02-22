# encoding: utf-8

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
require 'yard'
require 'pry'
require 'jeweler'
require 'rspec/core'
require 'rspec/core/rake_task'

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "darkholme"
  gem.homepage = "http://github.com/evanwalsh/darkholme"
  gem.license = "MIT"
  gem.summary = %Q{An entity-component system in Ruby for}
  gem.description = %Q{An entity-component system in Ruby}
  gem.email = "evan@massivedanger.com"
  gem.authors = ["Massive Danger"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
end

YARD::Rake::YardocTask.new

desc "Start a Pry console with the gem required"
task :pry do
  $LOAD_PATH.unshift("./lib")
  Dir["./lib/*.rb"].each do |file|
    Pry.config.requires << file
  end
  Pry.start
end

task :default => :spec
