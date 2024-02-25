local function keymap(key, desc, cb, opts)
  return vim.tbl_extend('keep', opts or {}, {
    '<leader>f' .. key,
    cb,
    silent = true,
    desc = 'fuzzyfinder: ' .. desc,
  })
end

return require('utils.table').join({
  keymap('f', 'find files', require('plugins.fuzzyfinder.commands').find_files),
  keymap('F', 'find files: current word', function()
    local word = require('utils').cword()

    require('plugins.fuzzyfinder.commands').find_files({
      default_text = word,
      prompt_title = string.format('find files (%s)', word),
    })
  end, {
    mode = { 'n', 'v' },
  }),
  keymap('_', 'find files: current word: underscore', function()
    local original_word = require('utils').cword()
    local word, _ = require('utils.string').snakecase(original_word):gsub('::', '/')

    require('plugins.fuzzyfinder.commands').find_files({
      default_text = word,
      prompt_title = string.format('find files (%s)', word),
    })
  end, {
    mode = { 'n', 'v' },
  }),
  keymap('p', 'resume', require('plugins.fuzzyfinder.commands').resume),
  keymap('y', 'live grep', require('plugins.fuzzyfinder.commands').live_grep),
  keymap('Y', 'live grep: current word', require('plugins.fuzzyfinder.commands').grep_string),
  keymap('a', 'finders', require('plugins.fuzzyfinder.commands').find_finders),
  keymap('s', 'tabs', require('plugins.fuzzyfinder.commands').find_tabs),
  keymap('h', 'help', require('plugins.fuzzyfinder.commands').help_tags),
  keymap('H', 'help: current word', function()
    local word = require('utils').cword()

    require('telescope.builtin').help_tags({
      default_text = word,
      prompt_title = string.format('help (%s)', word),
    })
  end, {
    mode = { 'n', 'v' },
  }),
  keymap('b', 'buffers', require('plugins.fuzzyfinder.commands').buffers),
  keymap('k', 'keymaps', require('plugins.fuzzyfinder.commands').keymaps, {
    mode = { 'n', 'v' },
  }),
  keymap('n', 'current buffer', require('plugins.fuzzyfinder.commands').current_buffer_fuzzy_find),
  keymap('N', 'current buffer: current word', function()
    local word = require('utils').cword()

    require('telescope.builtin').current_buffer_fuzzy_find({
      default_text = word,
      prompt_title = string.format('current buffer fuzzy (%s)', word),
    })
  end, {
    mode = { 'n', 'v' },
  }),
  keymap('o', 'oldfiles', require('plugins.fuzzyfinder.commands').oldfiles),
  keymap('t', 'treesitter', require('plugins.fuzzyfinder.commands').treesitter),
  keymap('m', 'marks', require('plugins.fuzzyfinder.commands').marks, {
    mode = { 'n', 'v' },
  }),
  keymap('d', 'current dir', require('plugins.fuzzyfinder.commands').current_dir, {
    mode = { 'n', 'v' },
  }),
  keymap('c', 'commands', require('plugins.fuzzyfinder.commands').commands, {
    mode = { 'n', 'v' },
  }),
  keymap('ey', 'extension:yml', function()
    require('plugins.fuzzyfinder.commands').find_files({
      extensions = 'yml',
    })
  end, { mode = { 'n', 'v' } }),
  keymap('em', 'extension:md', function()
    require('plugins.fuzzyfinder.commands').find_files({
      extensions = 'md',
    })
  end, { mode = { 'n', 'v' } }),
  keymap('er', 'extension:[rb, erb]', function()
    require('plugins.fuzzyfinder.commands').find_files({
      extensions = { 'rb', 'erb' },
    })
  end, { mode = { 'n', 'v' } }),
  keymap('eg', 'extension:go', function()
    require('plugins.fuzzyfinder.commands').find_files({
      extensions = 'go',
    })
  end, { mode = { 'n', 'v' } }),
  keymap('gg', 'git:files', require('plugins.fuzzyfinder.commands').git_files),
  keymap('gm', 'git:modified', function()
    local main = vim.fn.system('git-branch-main')

    require('plugins.fuzzyfinder.commands').find_files({
      find_command = {
        'git',
        'diff',
        '--name-only',
        '--relative',
        string.format('%s...', vim.trim(main)),
      },
      prompt_title = 'git: branch diff',
    })
  end),
  keymap('gd', 'git:diff', function()
    require('plugins.fuzzyfinder.commands').find_files({
      find_command = { 'git', 'ls-files', '--modified' },
      prompt_title = 'git: modified files',
    })
  end),
}, require('plugins.fuzzyfinder.keymaps.rails'))
