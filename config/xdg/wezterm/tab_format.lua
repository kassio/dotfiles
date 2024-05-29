local function get_zoomed(tab, icon)
  if tab.active_pane.is_zoomed then
    return ' ' .. icon
  end

  return ' '
end

local function get_separator(tab)
  if tab.tab_index >= 1 then
    return ''
  end

  return ' '
end

local function limit_pwd_size(value, counter)
  counter = counter or 0
  if #value > 60 then
    local i, _ = string.find(value, '/')
    return limit_pwd_size(string.sub(value, i + 1), counter + 1), true
  end

  return value, false
end

local function get_pwd(dir)
  local pane_dir = tostring(dir):sub(8)
  local HOME_DIR = os.getenv('HOME') or '/Users/kassioborges'

  if pane_dir:match(HOME_DIR) ~= nil then
    pane_dir = '~' .. pane_dir:sub(#HOME_DIR + 1)
  end

  local current_dir, reduced = limit_pwd_size(pane_dir)
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

local function get_title(tab)
  local pane_dir = tab.active_pane.current_working_dir

  if pane_dir == nil then
    return tab.active_pane.title
  end

  return string.format('%s> %s', get_pwd(pane_dir), get_process(tab))
end

return {
  setup = function(wezterm)
    wezterm.on('format-tab-title', function(tab, _tabs, _panes, _config, _hover, _max_width)
      return {
        {
          Text = table.concat({
            get_separator(tab),
            string.format('[%s:%s] ', tab.tab_index + 1, tab.active_pane.pane_id),
            get_title(tab),
            get_zoomed(tab, wezterm.nerdfonts.fa_arrows_alt),
          }, ''),
        },
      }
    end)
  end,
}
