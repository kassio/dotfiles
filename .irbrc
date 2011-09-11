require 'rubygems'
begin
  # load wirble
  require 'wirble'
  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

ARGV.concat ["--readline", "--prompt-mode", "simple"]
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:PROMPT_MODE] = :SIMPLE

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end 

puts 'Loaded ~/.irbrc'
