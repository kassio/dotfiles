local theme = vim.my.theme

local winbar_filetype_exclude = {
  '',
  'NvimTree',
  'TelescopePrompt',
  'fzf',
  'help',
  'neoterm',
  'packer',
}

local winbar = function(focused)
  return function()
    if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
      vim.opt_local.winbar = ''
    else
      local hl_background = focused and 'WinBar' or 'WinBarNC'
      local hl_filename = 'WinBarNC'
      if focused then
        hl_filename = 'WinBarInfo'
      end
      if vim.bo.modified then
        hl_filename = 'WinBarWarn'
      end

      pcall(
        vim.api.nvim_set_option_value,
        'winbar',
        table.concat({
          string.format('%%#%s#', hl_filename),
          ' %.100t',
          string.format('%%#%s#', hl_background),
          theme.icons.separator,
          vim.my.treesitter.gps.location(),
          '%<%=',
          string.format('%%#%s#', hl_filename),
          '%n',
          ' ',
        }, ''),
        { scope = 'local' }
      )
    end
  end
end

vim.my.utils.augroup('user:winbar', {
  {
    events = {
      'CursorMoved',
      'BufWinEnter',
      'WinEnter',
      'BufFilePost',
      'InsertEnter',
      'BufWritePost',
      'FocusLost',
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
