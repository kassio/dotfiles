return {
  setup = function(ffinder)
    vim.keymap.set('n', '<leader>fh', ffinder.helptags, { desc = 'find:help' })
    vim.keymap.set('n', '<leader>fk', ffinder.keymaps, { desc = 'find:keymaps' })
    vim.keymap.set('n', '<leader>fp', ffinder.resume, { desc = 'find:resume' })
  end
}
