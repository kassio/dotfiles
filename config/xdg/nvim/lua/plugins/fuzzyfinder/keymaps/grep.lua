return {
  setup = function(ffinder)
    vim.keymap.set('n', '<leader>fw', ffinder.live_grep, { desc = 'find:grep' })
    vim.keymap.set({ 'n', 'x' }, '<leader>fW', function ()
      local word = require('utils').cword()

      ffinder.live_grep({ query = word })
    end, { desc = 'find:grep:cword' })
  end
}
