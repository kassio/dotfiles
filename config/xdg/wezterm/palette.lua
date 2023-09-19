return {
  setup = function(wezterm)
    wezterm.on('augment-command-palette', function(_w, _p)
      return {
        {
          brief = 'Move pane to new tab',
          icon = 'md_tab',

          action = wezterm.action_callback(function(_window, pane)
            local tab = pane:move_to_new_tab()
            tab:activate()
          end),
        },
      }
    end)
  end,
}
