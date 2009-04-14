require 'rbconfig'

class CssDryerGenerator < Rails::Generator::Base

  def initialize(runtime_args, runtime_options = {})
    Dir.mkdir('lib/tasks') unless File.directory?('lib/tasks')
    super
  end
  
  def manifest
    record do |m|
      m.file "css_dryer_2.rake", "lib/tasks/css_dryer_2.rake"
    end
  end

end
