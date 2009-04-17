== DESCRIPTION:

This gem is based on Rails plugin 'css_dryer': http://github.com/airblade/css_dryer.
Unlike 'css_dryer', this one doesn't create any controllers and views.
Instead, it acts more like SASS, but uses css_dryer parser (which allows you to use completely
conventional css-syntax and write one-line css rules).

* Read 'install' section to find out how to use it with Rails or any other Ruby appplication.
* Read USAGE.markdown file to learn about css_dryer parser (copypasted from css_dryer README).

== REQUIREMENTS:

* ActiveResource gem

== INSTALL:

The following steps assume you're using a Rails application.
Adjust for using in other cases.

1) 

  sudo gem install cssdryer2
    
2) Put this is config/environments/development.rb:

  require 'css_dryer_2'
  
3) Go to rails application folder and run: 

  'script/generate cssdryer2'.

This will generate neccessary rake tasks. Step 2 is mandatory before that. 

4) In dev environment, to generate css on any changes in .ncss files, put this in ApplicationController:

  before_filter :ncss
  def ncss
    CssDryer2::FilesHandler.new(:settings => :rails).run if RAILS_ENV == 'development'
  end

You can also set custom directories for files, instead of using rails shortcut option:

  CssDryer2::FilesHandler.new(
    :source_path  => 'my_css_dir/ncss',
    :compile_path => 'my_css_dir',
    :tmp_path     => '/tmp',
    :force_compile => true
  )


5) While deploying Rails application to production, run rake task:

  rake ncss:compile

6) Now put your .ncss files in your 'public/stylesheets/ncss/' dir.
The compiler will put generated css files in 'public/stylesheets/' dir.


== HOW IT WORKS:

When you fire 'run' method, CssDryer2::FileHandler object checks if the .ncss files
changed (it stores their SHA1 in tmp dir). If they did, it recompiles them.

For Rails application it assumes that you store your .ncss files in 'public/stylesheets/ncss',
and it compiles .css files in 'public/stylesheets'.
You might want to add 'public/stylesheets/*.css' into your '.gitignore' file 

You can force reompile by providing the run method with':force_recompile => true' argument.
You can also recompile at any time by running 'rake ncss:compile'


== LICENSE:

(The MIT License)

Copyright (c) 2009

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
