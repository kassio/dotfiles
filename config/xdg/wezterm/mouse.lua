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
    }
  end,
}
