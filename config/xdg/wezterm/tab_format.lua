local function get_zoomed(tab)
  if tab.active_pane.is_zoomed then
    return '󰖲 '
  end

  return '  '
end

local function get_pwd(tab)
  local current_dir = tab.active_pane.current_working_dir:sub(8)
  local HOME_DIR = os.getenv('HOME')

  if current_dir:match(HOME_DIR) then
    return '~' .. current_dir:sub(#HOME_DIR + 1)
  end

  return current_dir
end

return {
  setup = function(wezterm)
    wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
      -- get only the basename of the process (last part of the path)
      local _, _, process_name = tab.active_pane.foreground_process_name:find('/([^/]*)$')

      local title = string.format(
        '%s %s %s | %s ',
        tab.tab_index + 1,
        get_zoomed(tab),
        get_pwd(tab),
        process_name
      )

      return { { Text = title } }
    end)
  end,
}
