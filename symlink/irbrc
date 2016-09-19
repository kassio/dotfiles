require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'

ARGV.concat ['--readline', '--prompt-mode', 'simple']
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
