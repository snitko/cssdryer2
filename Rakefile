require 'rubygems'
require 'rake/gempackagetask'

def generate_gemspec
  files = FileList["{lib}/**/*", "{generators}/**/*"].map { |i| "\"#{i}\"" }
  test_files = FileList["spec/**/*"].map { |i| "\"#{i}\"" }
  gemspec = File.read('gemspec.template')

  gemspec.sub!('$files', "[#{files.join(', ')}]")
  gemspec.sub!('$test_files', "[#{test_files.join(', ')}]")
  gemspec
end
 
spec = eval(generate_gemspec)

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true
  File.open('css_dryer_2.gemspec', 'w') { |f| f.puts generate_gemspec }
end 

task :generate_gemspec do
  File.open('css_dryer_2.gemspec', 'w') { |f| f.puts generate_gemspec }
end
