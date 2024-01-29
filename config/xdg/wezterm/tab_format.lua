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

local function limit_pwd_size(value, counter)
  if #value > 60 then
    local i, _ = string.find(value, '/')
    return limit_pwd_size(string.sub(value, i + 1), (counter or 0) + 1), true
  end

  return value, false
end

local function get_pwd(tab, wezterm)
  local current_dir = tab.active_pane.current_working_dir:sub(8)
  local HOME_DIR = os.getenv('HOME')

  if current_dir:match(HOME_DIR) then
    current_dir = '~' .. current_dir:sub(#HOME_DIR + 1)
  end

  local current_dir, reduced = limit_pwd_size(current_dir)
  if reduced then
    return '.../' .. current_dir
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
        string.format('[%s]', tab.active_pane.pane_id),
        get_pwd(tab, wezterm),
        '-',
        get_process(tab),
        get_zoomed(tab, wezterm),
      }, ' ')

      return { { Text = title } }
    end)
  end,
}
