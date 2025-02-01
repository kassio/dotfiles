return {
  setup = function(wezterm)
    return {
      { -- disable click
        event = { Up = { streak = 1, button = 'Left' } },
        action = wezterm.action.Nop,
      },
      { -- always copy selection
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'NONE',
        action = wezterm.action({ CompleteSelectionOrOpenLinkAtMouseCursor = 'Clipboard' }),
      },
      { -- paste on ctrl+click
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = wezterm.action.PasteFrom('Clipboard'),
      },
      { -- quicklook selection
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CMD|SHIFT',
        action = wezterm.action_callback(function(window, pane)
          local selection = window:get_selection_text_for_pane(pane)
          if selection ~= '' then
            wezterm.run_child_process({ 'qlmanage', '-p', selection })
          end
        end),
      },
      { -- open selection/link
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CMD',
        action = wezterm.action_callback(function(window, pane)
          local selection = window:get_selection_text_for_pane(pane)
          if selection ~= '' then
            wezterm.open_with(selection)
          else
            wezterm.action.OpenLinkAtMouseCursor()
          end
        end),
      },
    }
  end,
}
