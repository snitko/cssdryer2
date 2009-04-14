spec_root_dir = File.expand_path(File.dirname(__FILE__) + '/..')
require File.expand_path(spec_root_dir + '/spec_helper')

describe CssDryer2::NcssHandler do

  it "parses nccs and generates conventional css" do
    ncss = <<END
body {
  color: blue;
  p {
    color: red;
  }
}
<% ie7 do %>
h2 {
  margin-top: 1em;
}
<% end %>
END

    compiled_ncss = <<END
body {
  color: blue;
}
body p {
  color: red;
}
* + html h2 {
  margin-top: 1em;
}
END
    CssDryer2::NcssHandler.new.compile(ncss).should == compiled_ncss
  end

end
