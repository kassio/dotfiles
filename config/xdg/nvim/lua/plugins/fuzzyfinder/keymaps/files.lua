return {
  setup = function(keymap)
    return {
      keymap('f', '', require('plugins.fuzzyfinder.commands').find_files),
      keymap('F', 'files:word', function()
        local word = require('utils').cword()

        require('plugins.fuzzyfinder.commands').find_files({
          default_text = word,
          prompt_title = string.format('files:%s', word),
        })
      end, {
        mode = { 'n', 'v' },
      }),
      keymap('_', 'files:word:underscore', function()
        local original_word = require('utils').cword()
        local word, _ = require('utils.string').snakecase(original_word):gsub('::', '/')

        require('plugins.fuzzyfinder.commands').find_files({
          default_text = word,
          prompt_title = string.format('files:%s', word),
        })
      end, {
        mode = { 'n', 'v' },
      }),
      keymap('e', 'files:extension', require('plugins.fuzzyfinder.commands').find_by_ext),
      keymap('o', 'files:old', require('plugins.fuzzyfinder.commands').oldfiles),
      keymap('d', 'files:directory', require('plugins.fuzzyfinder.commands').current_dir, {
        mode = { 'n', 'v' },
      }),
    }
  end,
}
