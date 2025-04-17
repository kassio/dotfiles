local function keymap(key, cb, desc, opts)
  return vim.tbl_extend('keep', opts or {}, {
    '<leader>f' .. key,
    cb,
    silent = true,
    desc = table.concat({ 'find', desc }, ':'),
  })
end

return require('utils.table').join(
  {
    keymap('a', require('plugins.fuzzyfinder.commands').finders, 'finders'),
    keymap('p', require('plugins.fuzzyfinder.commands').resume, 'resume'),

    keymap('s', require('plugins.fuzzyfinder.commands').find_tabs, 'tabs'),
    keymap('b', require('plugins.fuzzyfinder.commands').buffers, 'buffers'),
    keymap('m', function()
      require('plugins.fuzzyfinder.commands').marks({ mark_type = 'local' })
    end, 'marks'),
    keymap('M', function()
      require('plugins.fuzzyfinder.commands').marks({ mark_type = 'all' })
    end, 'marks'),

    keymap('k', require('plugins.fuzzyfinder.commands').keymaps, 'keymaps', {
      mode = { 'n', 'v' },
    }),
    keymap('c', require('plugins.fuzzyfinder.commands').commands, 'commands', {
      mode = { 'n', 'v' },
    }),

    keymap('h', require('plugins.fuzzyfinder.commands').help_tags, 'help'),
    keymap('H', function()
      local word = require('utils').cword()

      require('telescope.builtin').help_tags({
        default_text = word,
        prompt_title = string.format('help:%s', word),
      })
    end, 'help: current word', { mode = { 'n', 'v' } }),

    keymap('t', require('plugins.fuzzyfinder.commands').treesitter, 'treesitter'),
  },

  require('plugins.fuzzyfinder.keymaps.files').setup(keymap),
  require('plugins.fuzzyfinder.keymaps.grep').setup(keymap),
  require('plugins.fuzzyfinder.keymaps.git').setup(keymap),
  require('plugins.fuzzyfinder.keymaps.rails').setup(keymap)
)
