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
        require('plugins.fuzzyfinder.commands').current_buffer_fuzzy_find({
          prompt_title = 'buffer',
        })
      end, 'buffer', { mode = { 'n', 'v' } }),

      keymap('N', function()
        local word = require('utils').cword()

        require('plugins.fuzzyfinder.commands').current_buffer_fuzzy_find({
          default_text = word,
          prompt_title = string.format('buffer:%s', word),
        })
      end, 'buffer:word', { mode = { 'n', 'v' } }),
    }
  end,
}
