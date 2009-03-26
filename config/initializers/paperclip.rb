# Imagemagick path for Paperclip image processing
if RAILS_ENV == "development"
  Paperclip.options[:command_path] = '/usr/local/bin/ImageMagick-6.4.8/bin'
end
Paperclip.options[:swallow_stderr] = false
