local winbar_filetype_exclude = {
  '',
  'NvimTree',
  'TelescopePrompt',
  'fzf',
  'help',
  'neoterm',
  'packer',
}

local colored = function(color, component)
  return string.format('%%#%s#%%(%s%%)', color, component)
end

vim.my.winbar = function()
  if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = ''
  else
    vim.opt_local.winbar = table.concat({
      ' %=',
      colored('lualine_a_normal', ' %n '),
      colored('lualine_b_normal', ' %.100f:%-7(%l:%c%)%<%m%r%h '),
      colored('lualine_c_normal', ' %3p%% '),
    }, '')
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
    callback = vim.my.winbar,
  },
})
