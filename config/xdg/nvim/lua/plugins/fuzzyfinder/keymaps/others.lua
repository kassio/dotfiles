return {
  setup = function(ffinder)
    vim.keymap.set('n', '<leader>fa', ffinder.builtin, { desc = 'find:finders' })
    vim.keymap.set('n', '<leader>fh', ffinder.helptags, { desc = 'find:help' })
    vim.keymap.set({ 'n', 'x' }, '<leader>fH', function()
      local word = require('utils').cword()

      ffinder.helptags({ query = word })
    end, { desc = 'find:help' })

    vim.keymap.set('n', '<leader>fm', ffinder.keymaps, { desc = 'find:keymaps' })
    vim.keymap.set('n', '<leader>fp', ffinder.resume, { desc = 'find:resume' })
  end
}
