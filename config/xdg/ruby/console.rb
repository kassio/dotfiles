# frozen_string_literal: true

if defined?(::Bundler)
  $LOAD_PATH.concat(Dir.glob(Bundler.bundle_path.join("gems/*/lib")))
end

require "pp"
load File.expand_path("extensions.rb", __dir__)
# Avoid defining global functions to avoid confusion!!
# Ideally, define a Kassio::Helper, module with the helper functions
load ".console.local.rb" if File.exist?(".console.local.rb")
