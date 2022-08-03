vim.my.utils.augroup('user:autocommands', {
  {
    events = {
      'BufWritePre',
      'FileWritePre',
    },
    callback = vim.my.buffers.trim,
  },
  {
    events = {
      'WinLeave',
    },
    callback = function()
      vim.opt_local.relativenumber = false
    end,
  },
  {
    events = {
      'WinEnter',
    },
    callback = function()
      vim.opt_local.relativenumber = true
    end,
  },
  {
    events = {
      'FocusLost',
      'TextChanged',
      'VimSuspend',
    },
    callback = function()
      if vim.bo.modifiable then
        vim.my.buffers.trim()
        vim.cmd('silent! update!')
      end
    end,
  },
})
