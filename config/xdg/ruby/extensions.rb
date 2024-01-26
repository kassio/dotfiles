# frozen_string_literal: true.execute

module Kassio
  extend self

  def load!
    # Avoid defining global functions to avoid confusion!!
    # Ideally, define a Kassio::Helper, module with the helper functions
    load ".console.local.rb" if File.exist?(".console.local.rb")
  end

  def reload = load!

  def copy(obj)
    msg = obj.is_a?(String) ? obj : obj.inspect

    `echo "#{msg}" | pbcopy`

    msg
  end

  def silence_rails_warnings!
    return unless defined?(Rails)

    ActiveSupport::Deprecation.silenced = true
  end

  def enable_active_record_log!
    return unless defined?(Rails)

    ActiveRecord::Base.logger = Logger.new($stdout)
  end

  def disable_active_record_log!
    return unless defined?(Rails)

    ActiveRecord::Base.logger = nil
  end
end

Kassio.silence_rails_warnings!
Kassio.disable_active_record_log!
