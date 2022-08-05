local winbar = function(focused)
  return function()
    local ft = vim.bo.filetype
    if ft == '' or vim.my.utils.plugin_filetype(ft) then
      vim.opt_local.winbar = ''
      return
    end

    local hl_filename
    if vim.bo.modified then
      hl_filename = 'WinBarWarn'
    elseif focused then
      hl_filename = 'WinBarInfo'
    else
      hl_filename = 'WinBarNC'
    end

    vim.api.nvim_set_option_value(
      'winbar',
      table.concat({
        string.format('%%#%s#', hl_filename),
        '%<%=', -- spacer
        '%n', -- bufnr
        vim.fn.expand('%:.'), -- filename
        '%<%=', -- spacer
      }, ' '),
      { scope = 'local' }
    )
  end
end

vim.my.utils.augroup('user:winbar', {
  {
    events = {
      'BufFilePost',
      'BufWinEnter',
      'BufWritePost',
      'CursorMoved',
      'FileType',
      'FileWritePost',
      'FocusLost',
      'InsertEnter',
      'VimLeavePre',
      'VimSuspend',
      'WinEnter',
      'WinLeave',
    },
    callback = winbar(true),
  },
  {
    events = {
      'WinLeave',
    },
    callback = winbar(false),
  },
})
