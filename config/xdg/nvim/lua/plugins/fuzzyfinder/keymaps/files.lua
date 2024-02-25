local function filemap(keymap, key, name, cb, opts)
  opts = opts or {}
  return keymap(key, table.concat({ 'files', name }, ':'), cb, opts)
end

return {
  setup = function(keymap)
    return {
      filemap(keymap, 'f', '', require('plugins.fuzzyfinder.commands').find_files),
      filemap(keymap, 'F', 'current word', function()
        local word = require('utils').cword()

        require('plugins.fuzzyfinder.commands').find_files({
          default_text = word,
          prompt_title = string.format('find files %s', word),
        })
      end, {
        mode = { 'n', 'v' },
      }),
      filemap(keymap, '_', 'current word:underscore', function()
        local original_word = require('utils').cword()
        local word, _ = require('utils.string').snakecase(original_word):gsub('::', '/')

        require('plugins.fuzzyfinder.commands').find_files({
          default_text = word,
          prompt_title = string.format('find files: %s', word),
        })
      end, {
        mode = { 'n', 'v' },
      }),
      filemap(keymap, 'e', 'by extension', require('plugins.fuzzyfinder.commands').find_by_ext),
      filemap(keymap, 'o', 'oldfiles', require('plugins.fuzzyfinder.commands').oldfiles),
      filemap(
        keymap,
        'd',
        'current dir',
        require('plugins.fuzzyfinder.commands').current_dir,
        { mode = { 'n', 'v' } }
      ),
    }
  end,
}
