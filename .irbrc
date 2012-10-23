require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'

begin
  require 'pry'
  Pry.start
  exit
rescue LoadError => e
  warn "=> Unable to load pry"
end

begin
  require Gem.all_load_paths.grep(/wirble/).first + '/wirble'
  Wirble.init
  Wirble.colorize
  colors = Wirble::Colorize.colors.merge({
    :object_class => :purple,
    :symbol_prefix => :purple
  })
  Wirble::Colorize.colors = colors
rescue LoadError => e
  warn "=> Unable to load wirble"
end

ARGV.concat ["--readline", "--prompt-mode", "simple"]
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

if defined?(ActiveRecord)
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end
