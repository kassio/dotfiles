# frozen_string_literal: true

require "pp"

def local_reload(local_helpers = ".ruby_console.local")
  load File.expand_path("ruby_console/extensions.rb", __dir__)
  load local_helpers if File.exist?(local_helpers)

  __reload if defined?(__reload)
end; local_reload
