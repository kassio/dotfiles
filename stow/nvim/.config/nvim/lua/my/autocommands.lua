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
      'BufEnter',
      'BufLeave',
      'FocusLost',
      'TextChanged',
      'VimLeave',
      'VimLeavePre',
      'VimSuspend',
    },

    callback = function()
      if vim.bo.modifiable then
        vim.my.buffers.trim()
        vim.cmd('silent! wall!')
      end
    end,
  },
})
