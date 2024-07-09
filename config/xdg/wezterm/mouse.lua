return {
  setup = function(wezterm)
    return {
      { -- disable click
        event = {
          Up = {
            streak = 1,
            button = 'Left',
          },
        },
        action = wezterm.action.Nop,
      },
      { -- open link
        event = {
          Up = {
            streak = 1,
            button = 'Left',
          },
        },
        mods = 'CMD',
        action = wezterm.action.OpenLinkAtMouseCursor,
      },
      { -- open any selection
        event = {
          Up = {
            streak = 1,
            button = 'Left',
          },
        },
        mods = 'CMD|SHIFT',
        action = wezterm.action_callback(function(window, pane)
          wezterm.open_with(window:get_selection_text_for_pane(pane))
        end),
      },
    }
  end,
}
