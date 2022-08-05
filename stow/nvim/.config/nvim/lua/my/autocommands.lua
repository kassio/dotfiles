vim.my.utils.augroup('user:autocommands', {
  {
    events = {
      'BufFilePre',
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
