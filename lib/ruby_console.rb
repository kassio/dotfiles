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
