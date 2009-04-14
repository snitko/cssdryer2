require 'digest'

module CssDryer2
  # This module is included in rake task or
  # anywhere (for example ApplicationController of Rails app)
  # you need to choose when and which files are compiled.
  class FilesHandler

    attr_accessor :source_path, :compile_path, :tmp_path, :force_compile

    def initialize(params = {})

    @force_compile = false

      if params[:settings] == :rails
        @source_path   = "#{RAILS_ROOT}/public/stylesheets/ncss"
        @compile_path  = "#{RAILS_ROOT}/public/stylesheets"
        @tmp_path      = "#{RAILS_ROOT}/tmp"
      end

      @source_path   = params[:source_path]   if params[:source_path] 
      @compile_path  = params[:compile_path]  if params[:compile_path]
      @tmp_path      ||= params[:tmp_path]      || Dir.tmpdir + '/css_dryer_2_gem/tmp'
      

      unless @source_path or @compile_path or @tmp_path
        raise "You have to set source_path, compile_path and tmp_path"
      end

      FileUtils.mkdir_p(@tmp_path + '/css_dryer_2') unless File.exist?(@tmp_path + '/css_dryer_2')
    end

    def run(params = {})
      files = Dir.new(@source_path + '/').entries
      files.delete_if { |f| !File.file?(@source_path + "/#{f}") or !(f =~ /.ncss$/) }
      files.each { |f| prepare_file(f, params[:force_compile] || @force_compile) }
    end

    def self.configure   
      yield(self)
    end

    private
    
    def prepare_file(file, force_compile)

      ncss = File.read(@source_path + "/#{file}")
      hashed_content = Digest::SHA1.hexdigest(ncss)

      # Check if the file has been updated since the last run
      if File.exist?(@tmp_path + "/css_dryer_2/#{file}")
        prev_hashed_content = File.read(@tmp_path + "/css_dryer_2/#{file}")
        return if prev_hashed_content == hashed_content and !@force_compile
      end        

      ncss = File.read(@source_path + "/#{file}")
      css  = CssDryer2::NcssHandler.new.compile(ncss)
      File.open(@compile_path + "/#{file.sub(/.ncss$/, '.css')}", 'w') { |f| f.write(css) } 
      File.open(@tmp_path + "/css_dryer_2/#{file}", 'w') { |f| f.write(hashed_content) } 
    end

  end
end
