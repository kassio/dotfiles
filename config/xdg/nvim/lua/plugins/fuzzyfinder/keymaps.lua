return {
  {
    '<leader>ff',
    require('plugins.fuzzyfinder.commands').find_files,
    silent = true,
    desc = 'telescope: find files',
  },
  {
    '<leader>fF',
    function()
      require('plugins.fuzzyfinder.commands').find_files({
        default_text = require('utils').cword(),
      })
    end,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: find files: current word/selection',
  },
  {
    '<leader>f_',
    function()
      local word = require('utils').cword()
      word, _ = require('utils.string').snakecase(word)

      require('plugins.fuzzyfinder.commands').find_files({
        default_text = word,
      })
    end,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: find file: current word/selection in underscore',
  },
  {
    '<leader>fp',
    require('plugins.fuzzyfinder.commands').resume,
    silent = true,
    desc = 'telescope: resume fuzzyfinder',
  },
  {
    '<leader>fy',
    require('plugins.fuzzyfinder.commands').live_grep,
    silent = true,
    desc = 'telescope: live grep',
  },
  {
    '<leader>fY',
    require('plugins.fuzzyfinder.commands').grep_string,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: grep word under cursor or selection',
  },
  {
    '<leader>fa',
    function()
      require('telescope.builtin').builtin({ previwer = false })
    end,
    silent = true,
    desc = 'telescope: finders',
  },
  {
    '<leader>fh',
    require('plugins.fuzzyfinder.commands').help_tags,
    silent = true,
    desc = 'telescope: help tags',
  },
  {
    '<leader>fH',
    function()
      require('telescope.builtin').help_tags({
        default_text = require('utils').cword(),
      })
    end,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: help tags',
  },
  {
    '<leader>fb',
    require('plugins.fuzzyfinder.commands').buffers,
    silent = true,
    desc = 'telescope: buffers',
  },
  {
    '<leader>fl',
    require('plugins.fuzzyfinder.commands').highlights,
    silent = true,
    desc = 'telescope: highlights',
  },
  {
    '<leader>fk',
    require('plugins.fuzzyfinder.commands').keymaps,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: keymaps',
  },
  {
    '<leader>fn',
    require('plugins.fuzzyfinder.commands').current_buffer_fuzzy_find,
    silent = true,
    desc = 'telescope: current buffer finder',
  },
  {
    '<leader>fN',
    function()
      require('telescope.builtin').current_buffer_fuzzy_find({
        default_text = require('utils').cword(),
      })
    end,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: find current word in current buffer',
  },
  {
    '<leader>fo',
    require('plugins.fuzzyfinder.commands').oldfiles,
    silent = true,
    desc = 'telescope: oldfiles',
  },
  {
    '<leader>ft',
    require('plugins.fuzzyfinder.commands').treesitter,
    silent = true,
    desc = 'telescope: treesitter',
  },
  {
    '<leader>fm',
    require('plugins.fuzzyfinder.commands').marks,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: marks',
  },
  {
    '<leader>fc',
    require('plugins.fuzzyfinder.commands').commands,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: commands',
  },
  {
    '<leader>fgg',
    require('plugins.fuzzyfinder.commands').git_files,
    silent = true,
    desc = 'telescope: git files',
  },
  {
    '<leader>fgm',
    function()
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
    end,
    silent = true,
    desc = 'telescope: git modified files',
  },
  {
    '<leader>fgd',
    function()
      require('plugins.fuzzyfinder.commands').find_files({
        find_command = { 'git', 'ls-files', '--modified' },
        prompt_title = 'git: modified files',
      })
    end,
    silent = true,
    desc = 'telescope: git branch diff',
  },
  {
    '<leader>fr',
    require('plugins.fuzzyfinder.commands').find_rails,
    silent = true,
    desc = 'telescope: rails (app, lib)',
  },
  {
    '<leader>fR',
    require('plugins.fuzzyfinder.commands').find_rails_tests,
    silent = true,
    desc = 'telescope: rails (app, lib, spec)',
  },
}
