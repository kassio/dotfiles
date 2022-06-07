vim.my.utils.augroup('user:autocommands', {
  {
    events = {
      'BufWritePre',
      'FileWritePre',
    },
    pattern = '*',
    callback = vim.my.buffers.trim,
  },
  {
    events = {
      'FocusLost',
      'TextChanged',
      'VimSuspend',
      'InsertLeavePre',
    },
    pattern = '*',
    callback = function()
      if vim.bo.modifiable then
        vim.my.buffers.trim()
        vim.cmd('silent! update!')
      end
    end,
  },
})
