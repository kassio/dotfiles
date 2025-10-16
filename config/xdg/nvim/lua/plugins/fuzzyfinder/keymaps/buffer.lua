return {
  setup = function(ffinder)
    vim.keymap.set('n', '<leader>fn', ffinder.blines, { desc = 'find:buffer' })
    vim.keymap.set({ 'n', 'x' }, '<leader>fN', function ()
      local word = require('utils').cword()

      ffinder.blines({ query = word })
    end, { desc = 'find:buffer:cword' })
  end
}
