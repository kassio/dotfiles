# frozen_string_literal: true

require 'interactive_editor'

def local_reload
  load File.expand_path("ruby_console/extensions.rb", __dir__)

  local_ruby_console = ".ruby_console.local"
  load local_ruby_console if File.exist?(local_ruby_console)

  __reload if defined?(__reload)
end
local_reload
