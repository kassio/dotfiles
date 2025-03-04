# frozen_string_literal: true.execute

module Kassio
  extend self

  KASSIO_LOG_FILE = defined?(Rails) ? Rails.root.join('log/kassio.log') : '/tmp/kassio.log'

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

  def log(*args, **kwargs)
    File.open(KASSIO_LOG_FILE, 'a') do |f|
      format(*args, **kwargs)
        .tap { |message| f << message }
        .tap { |message| puts message }
    end

    [args, kwargs]
  end

  def write(*args, **kwargs)
    File.open(KASSIO_LOG_FILE, 'a') do |f|
      format(*args, **kwargs)
        .tap { |message| f << message }
    end

    [args, kwargs]
  end

  def format(*args, **kwargs)
    args_body = args.length > 1 ? args.inspect : args.first

    ["» #{caller(4, 1).join}"]
      .tap { |rows| rows << args_body if args.length > 0 }
      .tap { |rows| rows << kwargs.inspect if kwargs.length > 0 }
      .then { |rows| "#{rows.join("\n")}\n\n" }
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

  def pbcopy(obj)
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
