local function keymap(key, desc, cb, opts)
  return vim.tbl_extend('keep', opts or {}, {
    '<leader>f' .. key,
    cb,
    silent = true,
    desc = 'find:' .. desc,
  })
end

return require('utils.table').join(
  {
    keymap('a', 'finders', require('plugins.fuzzyfinder.commands').finders),
    keymap('p', 'resume', require('plugins.fuzzyfinder.commands').resume),

    keymap('s', 'tabs', require('plugins.fuzzyfinder.commands').find_tabs),
    keymap('b', 'buffers', require('plugins.fuzzyfinder.commands').buffers),

    keymap('y', 'grep', require('plugins.fuzzyfinder.commands').live_grep),
    keymap('Y', 'grep:word', require('plugins.fuzzyfinder.commands').grep_string, {
      mode = { 'n', 'v' },
    }),

    keymap('k', 'keymaps', require('plugins.fuzzyfinder.commands').keymaps, {
      mode = { 'n', 'v' },
    }),
    keymap('c', 'commands', require('plugins.fuzzyfinder.commands').commands, {
      mode = { 'n', 'v' },
    }),

    keymap('h', 'help', require('plugins.fuzzyfinder.commands').help_tags),
    keymap('H', 'help: current word', function()
      local word = require('utils').cword()

      require('telescope.builtin').help_tags({
        default_text = word,
        prompt_title = string.format('help:%s', word),
      })
    end, { mode = { 'n', 'v' } }),

    keymap('t', 'treesitter', require('plugins.fuzzyfinder.commands').treesitter),

    keymap('n', 'buffer', require('plugins.fuzzyfinder.commands').current_buffer_fuzzy_find),
    keymap('N', 'buffer:word', function()
      local word = require('utils').cword()

      require('telescope.builtin').current_buffer_fuzzy_find({
        default_text = word,
        prompt_title = string.format('buffer:%s', word),
      })
    end, { mode = { 'n', 'v' } }),
  },

  require('plugins.fuzzyfinder.keymaps.files').setup(keymap),
  require('plugins.fuzzyfinder.keymaps.git').setup(keymap),
  require('plugins.fuzzyfinder.keymaps.rails').setup(keymap)
)
