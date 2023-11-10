return {
  'j-hui/fidget.nvim',
  tag = 'legacy',
  config = function()
    require('fidget').setup({ text = { spinner = 'dots' } })
    -- Also used on ui/notification
    vim.keymap.set('n', '<leader>nn', vim.cmd.FidgetClose, { desc = 'notification: dismiss' })
  end,
}
