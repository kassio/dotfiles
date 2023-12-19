local utils = require('utils')
return {
  setup = function()
    local aug = vim.api.nvim_create_augroup('user:focus', { clear = false })

    vim.api.nvim_create_autocmd({ 'VimResized' }, {
      group = aug,
      callback = function()
        local curtab = vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())
        vim.cmd.tabdo('wincmd =')
        vim.cmd.tabnext(curtab)
      end,
    })

    vim.api.nvim_create_autocmd({ -- autosave
      'BufEnter',
      'BufLeave',
      'FocusLost',
      'TextChanged',
      'VimLeavePre',
      'VimSuspend',
    }, {
      group = aug,
      callback = function()
        utils.on_each_non_plugin_window(utils.trim)
        vim.cmd('silent! wall')
      end,
    })

    vim.api.nvim_create_autocmd({ -- autoreload
      'FocusGained',
      'TermClose',
      'TermLeave',
      'RemoteReply',
    }, {
      command = 'checktime',
    })
  end,
}
