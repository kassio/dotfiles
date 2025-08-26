return {
  setup = function(wezterm)
    return {
      { -- disable click
        event = { Down = { streak = 1, button = 'Left' } },
        mods = 'NONE',
        action = wezterm.action.ClearSelection,
      },
      -- scrolling up
      {
        event = { Down = { streak = 1, button = { WheelUp = 1 } } },
        mods = 'NONE',
        action = wezterm.action.ScrollByLine(-20),
      },
      -- scrolling down
      {
        event = { Down = { streak = 1, button = { WheelDown = 1 } } },
        mods = 'NONE',
        action = wezterm.action.ScrollByLine(20),
      },
      { -- open selection/link
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CMD',
        action = wezterm.action_callback(function(window, pane)
          local selection = window:get_selection_text_for_pane(pane)

          wezterm.log_info(selection)
          if string.sub(selection, 1, 4) == 'http' then
            wezterm.open_with(selection)
          elseif selection ~= '' then
            local filepath = pane:get_current_working_dir().file_path .. '/' .. selection
            wezterm.open_with(filepath)
          else
            wezterm.action.OpenLinkAtMouseCursor()
          end
        end),
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
    }
  end,
}
