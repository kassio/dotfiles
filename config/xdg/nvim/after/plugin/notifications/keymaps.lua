-- keymaps for multiple plugins
vim.keymap.set('n', '<leader>nn', function()
  vim.cmd('fclose!')
  vim.cmd.FidgetClose()
end, { desc = 'notification: dismiss' })
