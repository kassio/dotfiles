return {
  setup = function(ffinder)
    require('plugins.fuzzyfinder.keymaps.file').setup(ffinder)
    require('plugins.fuzzyfinder.keymaps.buffer').setup(ffinder)
    require('plugins.fuzzyfinder.keymaps.grep').setup(ffinder)
    require('plugins.fuzzyfinder.keymaps.git').setup(ffinder)
    require('plugins.fuzzyfinder.keymaps.ruby').setup(ffinder)

    -- others
    vim.keymap.set('n', '<leader>fh', ffinder.helptags, { desc = 'find:help' })
    vim.keymap.set('n', '<leader>fk', ffinder.keymaps, { desc = 'find:keymaps' })
    vim.keymap.set('n', '<leader>fp', ffinder.resume, { desc = 'find:resume' })
  end
}
