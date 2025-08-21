return {
  setup = function(wezterm)
    return {
      { -- disable click
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'NONE',
        action = wezterm.action.Nop,
      },
      { -- disable click
        event = { Down = { streak = 1, button = 'Left' } },
        mods = 'NONE',
        action = wezterm.action.Nop,
      },
      -- Scrolling up
      {
        event = { Down = { streak = 1, button = { WheelUp = 1 } } },
        mods = 'NONE',
        action = wezterm.action.ScrollByLine(-20),
      },
      -- Scrolling down
      {
        event = { Down = { streak = 1, button = { WheelDown = 1 } } },
        mods = 'NONE',
        action = wezterm.action.ScrollByLine(20),
      },
      { -- always copy selection
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'NONE',
        action = wezterm.action({ CompleteSelectionOrOpenLinkAtMouseCursor = 'Clipboard' }),
      },
      { -- quicklook selection
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CMD|SHIFT',
        action = wezterm.action_callback(function(window, pane)
          local selection = window:get_selection_text_for_pane(pane)

          if selection ~= '' then
            local filepath = pane:get_current_working_dir().file_path .. '/' .. selection
            wezterm.run_child_process({ 'qlmanage', '-p', filepath })
          end
        end),
      },
      { -- open selection/link
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CMD',
        action = wezterm.action_callback(function(window, pane)
          local selection = window:get_selection_text_for_pane(pane)

          if selection ~= '' then
            local filepath = pane:get_current_working_dir().file_path .. '/' .. selection
            wezterm.open_with(filepath)
          else
            wezterm.action.OpenLinkAtMouseCursor()
          end
        end),
      },
    }
  end,
}
