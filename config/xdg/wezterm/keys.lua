-- https://wezfurlong.org/wezterm/config/keys.html#configuring-key-assignments
return {
  setup = function(wezterm)
    return {
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
        mods = 'SUPER|SHIFT',
        action = wezterm.action.ActivateCommandPalette,
      },
      { -- do not close window with cmd+q
        key = 'q',
        mods = 'CMD',
        action = wezterm.action.Nop,
      },
      { -- do not close pane with cmd+w
        key = 'w',
        mods = 'CMD',
        action = wezterm.action.Nop,
      },
      { -- close pane with cmd+shift+w
        key = 'w',
        mods = 'CMD|SHIFT',
        action = wezterm.action.CloseCurrentPane({ confirm = false }),
      },
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
        action = wezterm.action_callback(function(win, pane)
          if #pane:tab():panes() > 1 then
            win:perform_action(wezterm.action.TogglePaneZoomState, pane)
          end
        end),
      },
      -- Scrollback
      {
        key = 'k',
        mods = 'SUPER',
        action = wezterm.action.Multiple({
          wezterm.action.ClearScrollback('ScrollbackAndViewport'),
          wezterm.action.SendKey({ key = 'L', mods = 'CTRL' }),
        }),
      },
    }
  end,
}
