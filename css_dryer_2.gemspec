Gem::Specification.new do |s|
  s.name = "css_dryer_2"
  s.version = "0.1"
  s.author = "Roman Snitko"
  s.email = "roman@snitko.ru"
  s.homepage = "http://github.com/snitko/css_dryer_2"
  s.summary = "Parses dry css files and generates conventional css"
  s.files = FileList["{lib}/**/*", "{generators}/**/*"].to_a
  s.require_path = "lib"
  s.test_files = FileList["{spec}/*"].to_a
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc"]
  s.add_dependency("activeresource")
end
