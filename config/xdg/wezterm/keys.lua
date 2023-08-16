-- https://wezfurlong.org/wezterm/config/keys.html#configuring-key-assignments
return {
  setup = function(wezterm)
    local act = wezterm.action
    return {
      -- Font
      {
        key = '0',
        mods = 'SUPER',
        action = act.ResetFontSize,
      },
      {
        key = '+',
        mods = 'SUPER',
        action = act.IncreaseFontSize,
      },
      -- Panes create
      {
        key = 'd',
        mods = 'SUPER',
        action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
      },
      {
        key = 'd',
        mods = 'SUPER|SHIFT',
        action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
      },
      -- Panes focus
      {
        key = 'h',
        mods = 'SUPER|ALT',
        action = act.ActivatePaneDirection('Left'),
      },
      {
        key = 'j',
        mods = 'SUPER|ALT',
        action = act.ActivatePaneDirection('Down'),
      },
      {
        key = 'k',
        mods = 'SUPER|ALT',
        action = act.ActivatePaneDirection('Up'),
      },
      {
        key = 'l',
        mods = 'SUPER|ALT',
        action = act.ActivatePaneDirection('Right'),
      },
      -- Panes focus
      {
        key = 'h',
        mods = 'SUPER|ALT',
        action = act.ActivatePaneDirection('Left'),
      },
      {
        key = 'j',
        mods = 'SUPER|ALT',
        action = act.ActivatePaneDirection('Down'),
      },
      {
        key = 'k',
        mods = 'SUPER|ALT',
        action = act.ActivatePaneDirection('Up'),
      },
      {
        key = 'l',
        mods = 'SUPER|ALT',
        action = act.ActivatePaneDirection('Right'),
      },
      -- Panes resize
      {
        key = 'h',
        mods = 'SUPER|ALT',
        action = act.AdjustPaneSize({ 'Left', 1 }),
      },
      {
        key = 'j',
        mods = 'SUPER|ALT',
        action = act.AdjustPaneSize({ 'Down', 1 }),
      },
      {
        key = 'k',
        mods = 'SUPER|ALT',
        action = act.AdjustPaneSize({ 'Up', 1 }),
      },
      {
        key = 'l',
        mods = 'SUPER|ALT',
        action = act.AdjustPaneSize({ 'Right', 1 }),
      },
      {
        key = 'Enter',
        mods = 'SUPER|SHIFT',
        action = act.TogglePaneZoomState,
      },
    }
  end,
}
