return {
  setup = function(keymap)
    return {
      keymap('f', require('plugins.fuzzyfinder.commands').find_files, 'files'),
      keymap(
        'F',
        function()
          local word = require('utils').cword()

          require('plugins.fuzzyfinder.commands').find_files({
            default_text = word,
            prompt_title = string.format('files:%s', word),
          })
        end,
        'files:word',
        {
          mode = { 'n', 'v' },
        }
      ),
      keymap(
        '_',
        function()
          local original_word = require('utils').cword()
          local word, _ = require('utils.string').snakecase(original_word):gsub('::', '/')

          require('plugins.fuzzyfinder.commands').find_files({
            default_text = word,
            prompt_title = string.format('files:%s', word),
          })
        end,
        'files:word:underscore',
        {
          mode = { 'n', 'v' },
        }
      ),
      keymap('e', require('plugins.fuzzyfinder.commands').find_by_ext, 'files:extension'),
      keymap('o', require('plugins.fuzzyfinder.commands').oldfiles, 'files:old'),
    }
  end,
}
