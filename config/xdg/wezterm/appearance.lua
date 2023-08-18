return {
  setup = function(wezterm)
    local io = require('io')
    local os = require('os')

    wezterm.on('window-config-reloaded', function(window, pane)
      local dir = os.getenv('$XDG_CACHE_HOME') or wezterm.home_dir .. '/.cache'
      local file = dir .. '/term-profile'
      local f = io.open(file, 'w+')

      f:write(wezterm.gui.get_appearance():lower())
      f:flush()
      f:close()
    end)
  end,
}
