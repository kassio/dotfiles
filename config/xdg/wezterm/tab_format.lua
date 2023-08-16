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
      local zoomed = ''
      if tab.active_pane.is_zoomed then
        zoomed = '󰖲 '
      end

      -- get only the basename of the process (last part of the path)
      local process_name = tab.active_pane.foreground_process_name:gmatch('/([^/]*)$')()

      local title =
        string.format(' %s %s | %s ', zoomed, get_current_working_dir(tab), process_name)

      wezterm.log_error(title)

      return { { Text = title } }
    end)
  end,
}
