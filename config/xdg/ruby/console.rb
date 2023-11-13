# frozen_string_literal: true

if defined?(::Bundler)
  $LOAD_PATH.concat(Dir.glob(Bundler.bundle_path.join("gems/*/lib")))
end

require "pp"
load File.expand_path("extensions.rb", __dir__)

Kassio.load!
