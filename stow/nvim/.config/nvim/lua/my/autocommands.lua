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
      'FocusLost',
      'VimLeavePre',
      'VimSuspend',
      'BufLeave',
      'BufEnter',
    },
    callback = function()
      if vim.bo.modifiable then
        vim.my.buffers.trim()
        vim.cmd('silent! update!')
      end
    end,
  },
})
