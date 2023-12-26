local utils = require('utils')
return {
  setup = function()
    local aug = vim.api.nvim_create_augroup('user:focus', { clear = false })

    -- keep window sizes
    vim.api.nvim_create_autocmd({ 'VimResized' }, {
      group = aug,
      callback = function()
        local curtab = vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())
        vim.cmd.tabdo('wincmd =')
        vim.cmd.tabnext(curtab)
      end,
    })

    -- autotrim
    vim.api.nvim_create_autocmd({
      'BufLeave',
      'FocusLost',
      'VimLeavePre',
    }, {
      group = aug,
      callback = function()
        vim.cmd.Trim()
      end,
    })

    -- autosave
    vim.api.nvim_create_autocmd({
      'BufLeave',
      'FocusLost',
      'VimLeavePre',
    }, {
      group = aug,
      callback = function()
        vim.cmd('silent! write')
      end,
    })

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'TermSend',
      group = aug,
      callback = function()
        vim.cmd('silent! write')
      end,
    })

    -- autoreload
    vim.api.nvim_create_autocmd({
      'FocusGained',
      'TermClose',
      'TermLeave',
      'RemoteReply',
    }, {
      command = 'checktime',
    })
  end,
}
