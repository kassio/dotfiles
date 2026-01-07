return {
  setup = function(ffinder)
    vim.keymap.set('n', '<leader>fo', ffinder.oldfiles, { desc = 'find:oldfiles' })
    vim.keymap.set('n', '<leader>ff', ffinder.global, { desc = 'find:global' })

    vim.keymap.set({ 'n', 'x' }, '<leader>fF', function()
      local word = require('utils').cword()
      ffinder.files({ query = word })
    end, { desc = 'find:current word(underscore)' })

    vim.keymap.set({ 'n', 'x' }, '<leader>f_', function()
      local word = require('utils').cword()
      word, _ = require('utils.string').snakecase(word):gsub('::', '/')
      ffinder.files({ query = word })
    end, { desc = 'find:current word(underscore)' })
  end,
}
