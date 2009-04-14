# Handler for DRY stylesheets which can be registered with Rails
# as a new templating system.
#
# DRY stylesheets are piped through ERB and then CssDryer#process.
module CssDryer2

  class NcssHandler
    include CssDryer::Processor
    # In case user doesn't have helper or hasn't run generator yet.
    include StylesheetsHelper rescue nil

    def compile(template)
      output_buffer = String.new
      erb_compiled_template = ERB.new(template, nil, nil, "@output_buffer").result(binding)
      process(erb_compiled_template)
    end
  end

end
