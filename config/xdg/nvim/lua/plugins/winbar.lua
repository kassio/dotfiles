local api = vim.api
local utils = require('my.utils')
local hl = require('my.utils.highlights')
local colors = require('plugins.highlight.theme').colors

hl.def('WinBar', {
  background = colors.dark_highlight,
  foreground = colors.highlight,
  sp = colors.shadow,
})
hl.extend('WinBarNC', 'WinBar', { foreground = colors.shadow })
hl.extend('WinBarInfo', 'WinBar', { foreground = colors.info, bold = true })
hl.extend('WinBarWarn', 'WinBar', { foreground = colors.warn, bold = true })

local winbar = function(bufnr, focused)
  local hl_filename
  if api.nvim_buf_get_option(bufnr, 'modified') then
    hl_filename = 'WinBarWarn'
  elseif focused then
    hl_filename = 'WinBarInfo'
  else
    hl_filename = 'WinBarNC'
  end
  local filename = vim.fn.fnamemodify(api.nvim_buf_get_name(bufnr), ':.')

  return table.concat({
    string.format('%%#%s#', hl_filename),
    '%<%=',
    bufnr,
    filename,
    '%<%=',
  }, ' ')
end

local reload = function()
  local curwin = api.nvim_get_current_win()
  local curtab = api.nvim_get_current_tabpage()

  for _, winid in ipairs(api.nvim_tabpage_list_wins(curtab)) do
    local bufnr = api.nvim_win_get_buf(winid)
    local ft = api.nvim_buf_get_option(bufnr, 'filetype')

    if ft == '' or utils.plugin_filetype(ft) then
      api.nvim_win_set_option(winid, 'winbar', '')
    else
      api.nvim_win_set_option(winid, 'winbar', winbar(bufnr, winid == curwin))
    end
  end
end

utils.augroup('user:winbar', {
  {
    events = { 'User' },
    pattern = 'NotificationOpened',
    callback = reload,
  },
  {
    events = { 'User' },
    pattern = 'NotificationClosed',
    callback = reload,
  },
  {
    events = {
      'BufWrite',
      'FileType',
      'FileWritePost',
      'FocusLost',
      'SessionLoadPost',
      'TextChanged',
      'WinEnter',
      'WinLeave',
    },
    callback = reload,
  },
})
