# frozen_string_literal: true.execute

module Kassio
  extend self

  KASSIO_LOG_FILE = defined?(Rails) ? 'log/kassio.log' : '/tmp/kassio.log'

  def load!
    # Avoid defining global functions to avoid confusion!!
    # Ideally, define a Kassio::Helper, module with the helper functions
    load ".console.local.rb" if File.exist?(".console.local.rb")
  end

  def reload
    load!

    _reload if respond_to?(:_reload)
    self
  end

  def log(*args)
    args.tap do
      File.open(KASSIO_LOG_FILE, 'a') do |f|
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

    ActiveRecord::Base.logger = Class.new(Logger) do
      def add(severity, message = nil, progname = nil)
        File.write(KASSIO_LOG_FILE, message)
        super
      end
    end.new($stdout)

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
