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
      'BufLeave',
      'FocusLost',
      'WinLeave',
    },
    pattern = '*',
    callback = vim.my.buffers.autosave,
  },
})
