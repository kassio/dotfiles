# frozen_string_literal: true.execute

module Kassio
  extend self

  def load!
    # Avoid defining global functions to avoid confusion!!
    # Ideally, define a Kassio::Helper, module with the helper functions
    load ".console.local.rb" if File.exist?(".console.local.rb")
  end

  def reload
    load!
    self
  end

  def log(*args)
    args.tap do
      File.open('log/kassio.log', 'a') do |f|
        <<~EOF.tap { puts _1 }.tap { f << _1 }
        » << #{caller(3, 1)[0]} <<
        #{args.inspect}
        ──────────────────────────────────────────────────

        EOF
      end
    end
  end

  def log_active_record
    return yield unless defined?(Rails)

    ActiveRecord::Base.logger = Logger.new($stdout)

    yield.tap { ActiveRecord::Base.logger = nil }
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
