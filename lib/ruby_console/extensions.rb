# frozen_string_literal: true

class Object
  def __local_methods
    methods - self.class.superclass.instance_methods
  end
end

def __copy(obj)
  msg = obj.is_a?(String) ? obj : obj.inspect

  `echo "#{msg}" | pbcopy`
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

def disable_active_record_log!
  return unless defined?(Rails)

  current = ActiveRecord::Base.logger

  if current != nil
    @__original_active_record_logger = current
  end

  ActiveRecord::Base.logger = nil
end

silence_rails_warnings!
disable_active_record_log!
