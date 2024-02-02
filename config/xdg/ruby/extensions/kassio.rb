# frozen_string_literal: true.execute

module Kassio
  extend self

  def load!
    # Avoid defining global functions to avoid confusion!!
    # Ideally, define a Kassio::Helper, module with the helper functions
    load ".console.local.rb" if File.exist?(".console.local.rb")
  end

  def reload = load!

  def self.log(*args)
    File.open('log/kassio.log', 'a') do |f|
      f << "» " << caller(3, 1)[0] << "\n"
      args.each { |arg| f << arg.inspect << "\n" }
      f << "──────────────────────────────────────────────────" << "\n"
    end

    args
  end

  def copy(obj)
    `echo "#{obj.is_a?(String) ? obj : obj.inspect}" | pbcopy`

    obj
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
