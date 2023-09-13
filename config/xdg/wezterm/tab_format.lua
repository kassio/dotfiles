local function get_zoomed(tab, wezterm)
  if tab.active_pane.is_zoomed then
    return wezterm.nerdfonts.fa_arrows_alt
  end

  return ' '
end

local function get_separator(tab)
  if tab.tab_index >= 1 then
    return '▏'
  end

  return ' '
end

local function get_pwd(tab)
  local current_dir = tab.active_pane.current_working_dir:sub(8)
  local HOME_DIR = os.getenv('HOME')

  if current_dir:match(HOME_DIR) then
    return '~' .. current_dir:sub(#HOME_DIR + 1)
  end

  return current_dir
end

local function get_process(tab)
  local process_name = tab.active_pane.foreground_process_name

  -- Equivalent to POSIX basename(3)
  -- Given "/foo/bar" returns "bar"
  -- Given "c:\\foo\\bar" returns "bar"
  -- https://wezfurlong.org/wezterm/config/lua/pane/get_foreground_process_name.html
  local basename, _ = string.gsub(process_name, '(.*[/\\])(.*)', '%2')
  return basename
end

return {
  setup = function(wezterm)
    wezterm.on('format-tab-title', function(tab, _tabs, _panes, _config, _hover, _max_width)
      local title = table.concat({
        get_separator(tab),
        tab.tab_index + 1,
        get_zoomed(tab, wezterm),
        get_pwd(tab),
        '|',
        get_process(tab),
        ' ',
      }, ' ')

      return { { Text = title } }
    end)
  end,
}
