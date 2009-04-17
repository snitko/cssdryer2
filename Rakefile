require 'rubygems'
require 'hoe'
require File.dirname(__FILE__) + '/lib/css_dryer_2'

def generate_gemspec(options = {})
  files      = list_files.map     { |i| "\"#{i}\"" }
  test_files = list_testfiles.map { |i| "\"#{i}\"" }
  gemspec = File.read('gemspec.template')
  gemspec.sub!('$files', "[#{files.join(', ')}]")
  gemspec.sub!('$test_files', "[#{test_files.join(', ')}]")
  return "Gem::Specification.new do |s|\n" + gemspec + "\nend" if options[:in_block]
  gemspec
end

def list_files
  files = FileList["{lib}/**/*", "{generators}/**/*"]
end
def list_testfiles
  test_files = FileList["spec/**/*"]
end
 
spec = eval(generate_gemspec(:in_block => true))

Hoe.new('cssdryer2', '0.1') do |s|
  s.rubyforge_name = 'cssdryer2'
  s.developer('Roman Snitko', 'roman@snitko.ru')
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true
  File.open('css_dryer_2.gemspec', 'w') { |f| f.puts generate_gemspec }
end 

task :generate_gemspec do
  File.open('css_dryer_2.gemspec', 'w') { |f| f.puts generate_gemspec }
  `cd #{File.dirname(__FILE__)} && rake check_manifest | patch`
end
