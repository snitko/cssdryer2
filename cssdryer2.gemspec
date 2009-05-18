Gem::Specification.new do |s|
  s.name = "cssdryer2"
  s.version = "0.1.4"
  s.author = "Roman Snitko"
  s.email = "roman@snitko.ru"
  s.homepage = "http://github.com/snitko/cssdryer2"
  s.summary = "Parses dry css files and generates conventional css"
  s.files = ["lib/css_dryer_2.rb", "lib/css_dryer_2", "lib/css_dryer_2/processor.rb", "lib/css_dryer_2/files_handler.rb", "lib/css_dryer_2/stylesheets_helper.rb", "lib/css_dryer_2/ncss_handler.rb", "generators/cssdryer2", "generators/cssdryer2/cssdryer2_generator.rb", "generators/cssdryer2/templates", "generators/cssdryer2/templates/cssdryer2.rake", "README.txt", "Rakefile", "USAGE.markdown", "Manifest.txt", "History.txt"]
  s.require_path = "lib"
  s.test_files = ["spec/spec.opts", "spec/lib", "spec/lib/files_handler_spec.rb", "spec/lib/css_dryer_test.rb", "spec/lib/ncss_handler_spec.rb", "spec/example.ncss", "spec/spec_helper.rb", "spec/tmp", "spec/tmp/css_dryer_2"]
  s.add_dependency("activeresource")

end
