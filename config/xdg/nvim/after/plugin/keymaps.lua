-- keymaps for multiple plugins
vim.keymap.set('n', '<leader>nn', function()
  vim.cmd.FidgetClose()
  require('notify').dismiss()
end, { desc = 'notification: dismiss' })
