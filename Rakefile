require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "flixit"
    gem.summary = %Q{Interface with flixcloud.com api}
    gem.description = %Q{Performs requests and interprets responses with flixcloud.com}
    gem.email = "ilpoldo@gmail.com"
    gem.homepage = "http://github.com/ilpoldo/flixit"
    gem.authors = ["Leandro Pedroni"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "fredo", ">= 0.1.5"
    
    gem.add_dependency('restclient', '>= 1.4.0')
    gem.add_dependency('builder', '>= 2.1.1')
    gem.add_dependency('crack', '>= 0.1.6')
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "flixit #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
