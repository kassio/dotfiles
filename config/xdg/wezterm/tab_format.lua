local function get_zoomed(tab)
  if tab.active_pane.is_zoomed then
    return '󰖲 '
  end

  return ''
end

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir:sub(8)
  local HOME_DIR = os.getenv('HOME')

  if current_dir:match(HOME_DIR) then
    return '~' .. current_dir:sub(#HOME_DIR + 1)
  end

  return current_dir
end

return {
  setup = function(wezterm)
    wezterm.on('format-tab-title', function(tab)
      -- get only the basename of the process (last part of the path)
      local process_name = tab.active_pane.foreground_process_name:gmatch('/([^/]*)$')()

      local title =
        string.format(' %s %s | %s ', get_zoomed(tab), get_current_working_dir(tab), process_name)

      return { { Text = title } }
    end)
  end,
}
