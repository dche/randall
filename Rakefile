
require 'rake'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name = 'randall'
  s.version = '0.1'
  s.summary = 'Generate random instances of any classes.'
  s.description = s.summary
  
  s.author = 'Diego Che'
  s.email = 'chekenan@gmail.com'
  
  s.files = %w(README.rdoc LICENSE lib/regexp.treetop) + 
            Dir.glob('{lib, spec}/*.rb')
  
  s.required_ruby_version = '1.9'
  s.platform = Gem::Platform::RUBY
  
  s.add_dependency 'treetop', '>= 1.4.7'
  s.add_development_dependency 'bacon', '>= 1.1.0'
end

task :default => :spec

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_zip = true
  p.need_tar = true
end

desc 'Run spec'
task :spec do
  begin
    require 'bacon'
    Bacon.extend Bacon::TestUnitOutput
    
    Dir.glob('spec/*.rb').each do |f|
      require f
    end
    puts
  rescue LoadError
    $stderr.puts "Bacon is needed to run spec. "
  end
end
