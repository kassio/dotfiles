return {
  setup = function()
    local group = vim.api.nvim_create_augroup('user:focus', { clear = false })

    vim.api.nvim_create_autocmd({
      'VimResized',
    }, {
      group = group,
      callback = function()
        local curtab = vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())
        vim.cmd.tabdo('wincmd =')
        vim.cmd.tabnext(curtab)
      end,
    })

    vim.api.nvim_create_autocmd({
      'FocusGained',
      'TermClose',
      'TermLeave',
      'RemoteReply',
    }, {
      group = group,
      command = 'checktime',
    })
  end,
}