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
    '<leader>fey',
    function()
      require('plugins.fuzzyfinder.commands').find_files({
        extensions = 'yml',
      })
    end,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: find files yml',
  },
  {
    '<leader>fem',
    function()
      require('plugins.fuzzyfinder.commands').find_files({
        extensions = 'md',
      })
    end,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: find files markdown (md)',
  },
  {
    '<leader>fer',
    function()
      require('plugins.fuzzyfinder.commands').find_files({
        extensions = { 'rb', 'erb' },
      })
    end,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: find files ruby (rb, erb)',
  },
  {
    '<leader>feg',
    function()
      require('plugins.fuzzyfinder.commands').find_files({
        extensions = 'go',
      })
    end,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: find files golang (go)',
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
    '<leader>frr',
    function()
      require('plugins.fuzzyfinder.commands').find_rails()
    end,
    silent = true,
    desc = 'telescope: rails (all)',
  },
  {
    '<leader>fra',
    function()
      require('plugins.fuzzyfinder.commands').find_rails({ 'app', 'lib', 'ee/app', 'ee/lib' })
    end,
    silent = true,
    desc = 'telescope: rails (app, lib)',
  },
  {
    '<leader>frm',
    function()
      require('plugins.fuzzyfinder.commands').find_rails({ 'app/models', 'ee/app/models' })
    end,
    silent = true,
    desc = 'telescope: rails (models)',
  },
  {
    '<leader>frc',
    function()
      require('plugins.fuzzyfinder.commands').find_rails({ 'app/controllers', 'ee/app/controllers' })
    end,
    silent = true,
    desc = 'telescope: rails (controllers)',
  },
  {
    '<leader>frv',
    function()
      require('plugins.fuzzyfinder.commands').find_rails({ 'app/views', 'ee/app/views' })
    end,
    silent = true,
    desc = 'telescope: rails (views)',
  },
  {
    '<leader>frd',
    function()
      require('plugins.fuzzyfinder.commands').find_files({
        search_dirs = { 'doc' },
        prompt_title = 'rails (doc)',
      })
    end,
    silent = true,
    desc = 'telescope: rails (doc)',
  },
  {
    '<leader>fre',
    function()
      require('plugins.fuzzyfinder.commands').find_rails({ 'app/events', 'ee/app/events' })
    end,
    silent = true,
    desc = 'telescope: rails (events)',
  },
  {
    '<leader>frg',
    function()
      require('plugins.fuzzyfinder.commands').find_rails({ 'app/graphql', 'ee/app/graphql' })
    end,
    silent = true,
    desc = 'telescope: rails (graphql)',
  },
  {
    '<leader>frf',
    function()
      require('plugins.fuzzyfinder.commands').find_rails({ 'app/finders', 'ee/app/finders' })
    end,
    silent = true,
    desc = 'telescope: rails (finders)',
  },
  {
    '<leader>frs',
    function()
      require('plugins.fuzzyfinder.commands').find_rails({ 'app/services', 'ee/app/services' })
    end,
    silent = true,
    desc = 'telescope: rails (services)',
  },
  {
    '<leader>frl',
    function()
      require('plugins.fuzzyfinder.commands').find_rails({ 'app/lib', 'ee/app/lib' })
    end,
    silent = true,
    desc = 'telescope: rails (lib)',
  },
  {
    '<leader>frt',
    function()
      require('plugins.fuzzyfinder.commands').find_rails({ 'spec', 'ee/spec' })
    end,
    silent = true,
    desc = 'telescope: rails (spec)',
  },
  {
    '<leader>frw',
    function()
      require('plugins.fuzzyfinder.commands').find_rails({ 'app/workers', 'ee/app/workers' })
    end,
    silent = true,
    desc = 'telescope: rails (spec)',
  },
}
