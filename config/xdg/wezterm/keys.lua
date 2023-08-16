-- https://wezfurlong.org/wezterm/config/keys.html#configuring-key-assignments
return {
  setup = function(wezterm)
    return {
      -- Font resize
      {
        key = '0',
        mods = 'SUPER',
        action = wezterm.action.ResetFontSize,
      },
      {
        key = '+',
        mods = 'SUPER',
        action = wezterm.action.IncreaseFontSize,
      },
      -- Panes create
      {
        key = 'd',
        mods = 'SUPER',
        action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
      },
      {
        key = 'd',
        mods = 'SUPER|SHIFT',
        action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
      },
      -- Panes focus
      {
        key = 'h',
        mods = 'SUPER|ALT',
        action = wezterm.action.ActivatePaneDirection('Left'),
      },
      {
        key = 'j',
        mods = 'SUPER|ALT',
        action = wezterm.action.ActivatePaneDirection('Down'),
      },
      {
        key = 'k',
        mods = 'SUPER|ALT',
        action = wezterm.action.ActivatePaneDirection('Up'),
      },
      {
        key = 'l',
        mods = 'SUPER|ALT',
        action = wezterm.action.ActivatePaneDirection('Right'),
      },
      -- Panes resize
      {
        key = 'h',
        mods = 'SUPER|CTRL',
        action = wezterm.action.AdjustPaneSize({ 'Left', 3 }),
      },
      {
        key = 'j',
        mods = 'SUPER|CTRL',
        action = wezterm.action.AdjustPaneSize({ 'Down', 3 }),
      },
      {
        key = 'k',
        mods = 'SUPER|CTRL',
        action = wezterm.action.AdjustPaneSize({ 'Up', 3 }),
      },
      {
        key = 'l',
        mods = 'SUPER|CTRL',
        action = wezterm.action.AdjustPaneSize({ 'Right', 3 }),
      },
      {
        key = 'Enter',
        mods = 'SUPER|SHIFT',
        action = wezterm.action.TogglePaneZoomState,
      },
      -- Window
      {
        key = 'Enter',
        mods = 'SUPER',
        action = wezterm.action_callback(function(win)
          win:maximize()
        end),
      },
      {
        key = 'p',
        mods = 'SUPER',
        action = wezterm.action.ActivateCommandPalette,
      },
    }
  end,
}
