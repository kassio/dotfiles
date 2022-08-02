local winbar_filetype_exclude = {
  '',
  'NvimTree',
  'TelescopePrompt',
  'TelescopeResults',
  'fzf',
  'help',
  'neoterm',
  'packer',
}

local winbar = function(focused)
  return function()
    if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
      vim.opt_local.winbar = ''
      return
    end

    local hl_filename
    if focused then
      hl_filename = 'WinBarInfo'
    elseif vim.bo.modified then
      hl_filename = 'WinBarWarn'
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
      'BufWinEnter',
      'WinEnter',
      'BufFilePost',
      'InsertEnter',
      'BufWritePost',
      'FocusLost',
      'FileType',
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
