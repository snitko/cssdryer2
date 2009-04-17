  s.name = "css_dryer_2"
  s.version = "0.1"
  s.author = "Roman Snitko"
  s.email = "roman@snitko.ru"
  s.homepage = "http://github.com/snitko/css_dryer_2"
  s.summary = "Parses dry css files and generates conventional css"
  s.files = ["lib/css_dryer_2.rb", "lib/css_dryer_2", "lib/css_dryer_2/processor.rb", "lib/css_dryer_2/files_handler.rb", "lib/css_dryer_2/stylesheets_helper.rb", "lib/css_dryer_2/ncss_handler.rb", "generators/css_dryer", "generators/css_dryer/templates", "generators/css_dryer/templates/css_dryer_2.rake", "generators/css_dryer/css_dryer_generator.rb"]
  s.require_path = "lib"
  s.test_files = ["spec/spec.opts", "spec/lib", "spec/lib/files_handler_spec.rb", "spec/lib/css_dryer_test.rb", "spec/lib/ncss_handler_spec.rb", "spec/example.ncss", "spec/spec_helper.rb", "spec/tmp", "spec/tmp/css_dryer_2"]
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc"]
  s.add_dependency("activeresource")
