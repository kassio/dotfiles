return {
  setup = function(keymap)
    return {
      keymap('w', require('plugins.fuzzyfinder.commands').grep, 'grep'),
      keymap('W', function()
        local word = require('utils').cword()

        require('plugins.fuzzyfinder.commands').grep({
          default_text = word,
          prompt_title = string.format('grep:%s', word),
        })
      end, 'grep:word', { mode = { 'n', 'v' } }),

      keymap('n', function()
        local search_dir = { vim.fn.expand('%') }

        require('plugins.fuzzyfinder.commands').grep({
          search_dirs = search_dir,
          prompt_title = 'buffer',
        })
      end, 'buffer'),

      keymap('N', function()
        local search_dir = { vim.fn.expand('%') }
        local word = require('utils').cword()

        require('plugins.fuzzyfinder.commands').grep({
          default_text = word,
          search_dirs = search_dir,
          prompt_title = string.format('buffer:%s', word),
        })
      end, 'buffer:word', { mode = { 'n', 'v' } }),
    }
  end,
}
