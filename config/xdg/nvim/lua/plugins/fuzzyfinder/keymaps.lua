local commands = require('plugins.fuzzyfinder.commands')

return {
  {
    '<leader>ff',
    function()
      require('telescope.builtin').find_files({
        -- include hidden files
        find_command = commands.find,
      })
    end,
    silent = true,
    desc = 'telescope: find files',
  },
  {
    '<leader>fF',
    function()
      require('telescope.builtin').find_files({
        -- include hidden files
        find_command = commands.find,
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

      require('telescope.builtin').find_files({
        -- include hidden files
        find_command = commands.find,
        default_text = word,
      })
    end,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: find file: current word/selection in underscore',
  },
  {
    '<leader>fp',
    function()
      require('telescope.builtin').resume()
    end,
    silent = true,
    desc = 'telescope: resume fuzzyfinder',
  },
  {
    '<leader>fy',
    function()
      require('telescope.builtin').live_grep()
    end,
    silent = true,
    desc = 'telescope: live grep',
  },
  {
    '<leader>fY',
    function()
      require('telescope.builtin').grep_string()
    end,
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
    function()
      require('telescope.builtin').help_tags()
    end,
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
    function()
      require('telescope.builtin').buffers()
    end,
    silent = true,
    desc = 'telescope: buffers',
  },
  {
    '<leader>fl',
    function()
      require('telescope.builtin').highlights()
    end,
    silent = true,
    desc = 'telescope: highlights',
  },
  {
    '<leader>fk',
    function()
      require('telescope.builtin').keymaps()
    end,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: keymaps',
  },
  {
    '<leader>fn',
    function()
      require('telescope.builtin').current_buffer_fuzzy_find()
    end,
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
    function()
      require('telescope.builtin').oldfiles()
    end,
    silent = true,
    desc = 'telescope: oldfiles',
  },
  {
    '<leader>ft',
    function()
      require('telescope.builtin').treesitter()
    end,
    silent = true,
    desc = 'telescope: treesitter',
  },
  {
    '<leader>fm',
    function()
      require('telescope.builtin').commands()
    end,
    silent = true,
    mode = { 'n', 'v' },
    desc = 'telescope: commands',
  },
  {
    '<leader>fgg',
    function()
      require('telescope.builtin').git_files()
    end,
    silent = true,
    desc = 'telescope: git files',
  },
  {
    '<leader>fgm',
    function()
      local main = vim.fn.system('git-branch-main')

      require('telescope.builtin').find_files({
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
      require('telescope.builtin').find_files({
        find_command = { 'git', 'ls-files', '--modified' },
        prompt_title = 'git: modified files',
      })
    end,
    silent = true,
    desc = 'telescope: git branch diff',
  },
  {
    '<leader>fr',
    function()
      require('telescope.builtin').find_files({
        find_command = commands.find_ruby,
        search_dirs = { 'app', 'lib', 'ee/app', 'ee/lib' },
        prompt_title = 'rails (app, lib)',
      })
    end,
    silent = true,
    desc = 'telescope: rails (app, lib)',
  },
  {
    '<leader>fR',
    function()
      require('telescope.builtin').find_files({
        find_command = commands.find_ruby,
        search_dirs = { 'app', 'lib', 'spec', 'ee/app', 'ee/lib', 'ee/spec' },
        prompt_title = 'rails (app, lib, spec)',
      })
    end,
    silent = true,
    desc = 'telescope: rails (app, lib, spec)',
  },
}
