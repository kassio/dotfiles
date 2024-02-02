# frozen_string_literal: true.execute

load("#{ENV['HOME']}/.dotfiles/config/xdg/ruby/extensions/kassio.rb")

Kassio.silence_rails_warnings!
Kassio.disable_active_record_log!
