require 'rubygems'
begin
  require "pry"
  Pry.start
  exit
rescue LoadError => e
  warn "=> Unable to load pry"
end

ARGV.concat ["--readline", "--prompt-mode", "simple"]
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:PROMPT_MODE] = :SIMPLE

puts 'Loaded ~/.irbrc'

