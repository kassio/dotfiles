# vim: ft=ruby
# frozen_string_literal: true

Pry.config.collision_warning = true
Pry.config.pager = false
Pry.config.history_file = "#{ENV["HOME"]}/.irb_history"

Pry::Commands.command(/^$/, "repeat last command") do
  pry_instance.run_command Pry.history.to_a.last
end

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 's', 'step'
end

def _custom_prompt
  prefix = if defined?(Rails)
    formatted_env =
      case Rails.env
      when "production"
        bold_upcased_env = Pry::Helpers::Text.bold("prd")
        Pry::Helpers::Text.red(bold_upcased_env)
      when "staging"
        Pry::Helpers::Text.yellow("stg")
      when "development"
        Pry::Helpers::Text.green("dev")
      else
        Rails.env
      end
    "[#{formatted_env}]"
  else
    ""
  end

  level = ->(n) { n.zero? ? "" : ":#{n}" }

  Pry::Prompt.add(:custom, "", %w[> *]) do |target_self, nest_level, _pry_instance, sep|
    "#{prefix}(#{Pry.view_clip(target_self)})" \
      "#{level.call(nest_level)}#{sep} "
  end

  Pry::Prompt[:custom]
end

Pry.config.prompt = _custom_prompt

load "#{ENV["HOME"]}/.dotfiles/lib/ruby_console.rb"
