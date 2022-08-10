# frozen_string_literal: true

if defined?(::Bundler)
  $LOAD_PATH.concat(Dir.glob(Bundler.bundle_path.join("gems/*/lib")))
end

require "pp"

def local_reload(local_helpers = ".ruby_console.local")
  load File.expand_path("extensions.rb", __dir__)
  load local_helpers if File.exist?(local_helpers)

  __reload if defined?(__reload)
end; local_reload
