require 'css_dryer_2'

namespace(:ncss) do

  desc "compile ncss files into css"
  task :compile do
    CssDryer2::FilesHandler.new(:force_compile => true, :settings => :rails).run
  end

end
