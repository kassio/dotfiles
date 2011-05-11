require 'rubygems'
begin
  # load wirble
  %x{gem install 'wirble' --no-ri --no-rdoc} unless Gem.available?('wirble')
  Gem.refresh 
  require 'wirble'
  # start wirble (with color)
  Wirble.init
  Wirble.colorize
  colors = Wirble::Colorize.colors.merge({
    :object_class => :purple,
    :symbol_prefix => :purple
  })
  Wirble::Colorize.colors = colors
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

ARGV.concat ["--readline", "--prompt-mode", "simple"]
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:LOAD_MODULES] = [] unless IRB.conf.key?(:LOAD_MODULES)

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end 

puts 'Loaded ~/.irbrc'
