local winbar_filetype_exclude = {
  '',
  'NvimTree',
  'TelescopePrompt',
  'fzf',
  'help',
  'neoterm',
  'packer',
}

local winbar = function(hl)
  return function()
    if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
      vim.opt_local.winbar = ''
    else
      local highlight = vim.bo.modified and 'WinBarWarn' or hl

      pcall(
        vim.api.nvim_set_option_value,
        'winbar',
        table.concat({
          string.format('%%#%s#', highlight),
          ' %.100t',
          ' › ',
          vim.my.treesitter.gps.location(),
          '%<%=',
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
      'BufFilePost',
      'InsertEnter',
      'BufWritePost',
    },
    callback = winbar('WinBar'),
  },
  {
    events = {
      'BufLeave',
      'BufWinLeave',
    },
    callback = winbar('WinBarNC'),
  },
})
