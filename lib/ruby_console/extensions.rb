# frozen_string_literal: true

class Object
  def __local_methods
    methods - self.class.superclass.instance_methods
  end
end

def silence_rails_warnings!
  ActiveSupport::Deprecation.silenced = true
end

def toggle_active_record_log!
  current = ActiveRecord::Base.logger

  if current != @__original_active_record_logger
    ActiveRecord::Base.logger = @__original_active_record_logger
    @__original_active_record_logger = current
  end

  ActiveRecord::Base.logger
end

silence_rails_warnings!
toggle_active_record_log!
