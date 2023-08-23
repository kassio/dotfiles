# frozen_string_literal: true

class Object
  def __local_methods
    methods - self.class.superclass.instance_methods
  end
end

module Kassio
  extend self

  def copy(obj)
    msg = obj.is_a?(String) ? obj : obj.inspect

    `echo "#{msg}" | pbcopy`

    msg
  end

  def silence_rails_warnings!
    return unless defined?(Rails)

    ActiveSupport::Deprecation.silenced = true
  end

  def toggle_active_record_log!
    return unless defined?(Rails)

    current = ActiveRecord::Base.logger

    if current != @__original_active_record_logger
      ActiveRecord::Base.logger = @__original_active_record_logger
      @__original_active_record_logger = current
    end

    ActiveRecord::Base.logger
  end

  def enable_active_record_log!
    return unless defined?(Rails)

    ActiveRecord::Base.logger = Logger.new($stdout)
  end

  def disable_active_record_log!
    return unless defined?(Rails)

    current = ActiveRecord::Base.logger

    if current != nil
      @__original_active_record_logger = current
    end

    ActiveRecord::Base.logger = nil
  end
end

Kassio.silence_rails_warnings!
Kassio.disable_active_record_log!
