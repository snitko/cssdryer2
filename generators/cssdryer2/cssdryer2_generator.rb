require 'rbconfig'

class Cssdryer2Generator < Rails::Generator::Base

  def initialize(runtime_args, runtime_options = {})
    Dir.mkdir('lib/tasks') unless File.directory?('lib/tasks')
    super
  end
  
  def manifest
    record do |m|
      m.file "cssdryer2.rake", "lib/tasks/cssdryer2.rake"
    end
  end

end
