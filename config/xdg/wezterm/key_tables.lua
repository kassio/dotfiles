-- https://wezfurlong.org/wezterm/config/key-tables.html
return {
  setup = function(wezterm)
    return {
      search_mode = {
        {
          key = 'Enter',
          mods = 'NONE',
          action = wezterm.action.Multiple({
            wezterm.action.CopyTo('ClipboardAndPrimarySelection'),
            wezterm.action.CopyMode('Close'),
          }),
        },
        {
          key = 'Enter',
          mods = 'CMD',
          action = wezterm.action.Multiple({
            wezterm.action.CopyTo('ClipboardAndPrimarySelection'),
            wezterm.action.CopyMode('Close'),
            wezterm.action.PasteFrom('Clipboard'),
          }),
        },
        { key = 'Escape', mods = 'NONE', action = wezterm.action.CopyMode('Close') },
        { key = 'f', mods = 'CTRL', action = wezterm.action.CopyMode('CycleMatchType') },
        { key = 'n', mods = 'CTRL', action = wezterm.action.CopyMode('NextMatch') },
        { key = 'p', mods = 'CTRL', action = wezterm.action.CopyMode('PriorMatch') },
        { key = 'u', mods = 'CTRL', action = wezterm.action.CopyMode('ClearPattern') },
      },
    }
  end,
}
