# frozen_string_literal: true

def local_reload
  load File.expand_path("ruby_console/extensions.rb", __dir__)

  local_ruby_console = ".ruby_console.local"
  load local_ruby_console if File.exist?(local_ruby_console)
end
local_reload
