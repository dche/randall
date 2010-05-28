
require 'rake'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name = 'nextrand'
  s.version = '1.0'
  s.summary = 'Generate random instances of any classes.'
  
  s.files = %w(README.rdoc lib/regexp.treetop) + Dir.glob('{lib, spec}/*.rb')
  
  s.required_ruby_version = '1.9'
  s.platform = Gem::Platform::RUBY
end

task :default => :spec

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_zip = true
  p.need_tar = true
end

desc 'Update to rubygems.org.'
task 'gem:push' => [:gem] do
end

desc 'Run spec'
task :spec do
  begin
    require 'bacon'
    
    
  rescue LoadError
    $stderr.puts "Latest "
  end
end

desc 'Bump version number.'
task :version do
end
