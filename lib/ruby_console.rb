def silence_rails_warnings!
  ActiveSupport::Deprecation.silenced = true
end
