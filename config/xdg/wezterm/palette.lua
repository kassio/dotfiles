return {
  setup = function(wezterm)
    wezterm.on('augment-command-palette', function(_w, _p)
      return {
        {
          brief = 'Pane: Move to new tab',
          icon = 'md_tab',
          action = wezterm.action_callback(function(_window, pane)
            local tab = pane:move_to_new_tab()
            tab:activate()
          end),
        },
        {
          brief = 'Pane: Move to new window',
          icon = 'md_window_restore',
          action = wezterm.action_callback(function(_window, pane)
            local tab = pane:move_to_new_window()
            tab:activate()
          end),
        },
      }
    end)
  end,
}
