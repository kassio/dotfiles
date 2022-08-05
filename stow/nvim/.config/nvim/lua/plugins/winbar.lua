local api = vim.api

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

vim.my.utils.augroup('user:winbar', {
  {
    events = {
      'FileType',
      'FileWritePost',
      'FocusLost',
      'InsertEnter',
      'TextChanged',
      'VimLeavePre',
      'VimSuspend',
      'WinEnter',
      'WinLeave',
    },
    callback = function()
      local curwin = api.nvim_get_current_win()

      for _, winid in ipairs(api.nvim_list_wins()) do
        local bufnr = api.nvim_win_get_buf(winid)
        local ft = api.nvim_buf_get_option(bufnr, 'filetype')

        if ft == '' or vim.my.utils.plugin_filetype(ft) then
          api.nvim_win_set_option(winid, 'winbar', '')
        else
          api.nvim_win_set_option(winid, 'winbar', winbar(bufnr, winid == curwin))
        end
      end
    end,
  },
})
