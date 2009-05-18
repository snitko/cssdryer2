spec_root_dir = File.expand_path(File.dirname(__FILE__) + '/..')
require File.expand_path(spec_root_dir + '/spec_helper')

describe CssDryer2::FilesHandler do

  it "sets settings for files paths" do
    file_handler = CssDryer2::FilesHandler.new(
      :source_path  => '/home/user/public_html/css/ncss',
      :compile_path => '/home/user/public_html/css'
    )
    file_handler.source_path.should  == '/home/user/public_html/css/ncss'
    file_handler.compile_path.should == '/home/user/public_html/css'
    file_handler.tmp_path.should     == Dir.tmpdir + '/css_dryer_2_gem/tmp'
  end

  it "compiles files from the 'source' dir" do

    FileUtils.mkdir_p(Dir.tmpdir + '/css_dryer_2_gem/css/ncss') unless File.exist?(Dir.tmpdir + '/css_dryer_2_gem/css/ncss')
    FileUtils.mkdir(Dir.tmpdir + '/css_dryer_2_gem/tmp') unless File.exist?(Dir.tmpdir + '/css_dryer_2_gem/tmp')

    file_handler = CssDryer2::FilesHandler.new(
      :source_path  => spec_root_dir,
      :compile_path => Dir.tmpdir + '/css_dryer_2_gem/css',
      :force_compile => true
    )

    file_handler.run()
    Dir.new(Dir.tmpdir + '/css_dryer_2_gem/css').entries.should include('example.css')
  end

  it "forces compile when the flag is set" do
    file_handler = CssDryer2::FilesHandler.new(
      :source_path  => spec_root_dir,
      :compile_path => Dir.tmpdir + '/css_dryer_2_gem/css',
      :force_compile => true
    )
    file_handler.should_receive(:prepare_file).with('example.ncss', true).once
    file_handler.run
  end
  it "does not force compile if the flag is not set" do
    file_handler = CssDryer2::FilesHandler.new(
      :source_path  => spec_root_dir,
      :compile_path => Dir.tmpdir + '/css_dryer_2_gem/css',
      :force_compile => false
    )
    file_handler.should_receive(:prepare_file).with('example.ncss', false).once
    file_handler.run
  end

  after(:each) do
    # cleaning up
    FileUtils.rm_rf(Dir.tmpdir + '/css_dryer_2_gem')
  end

end
