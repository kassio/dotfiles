return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  cmd = 'Telescope',
  keys = {
    {
      '<leader>f;',
      function()
        require('telescope.builtin').find_files(require('telescope.themes').get_ivy())
      end,
      silent = true,
      desc = 'telescope: files [non block]',
    },
    {
      '<leader>ff',
      function()
        require('telescope.builtin').find_files({
          -- include hidden files
          find_command = {
            'rg',
            '--files',
            '--hidden',
            '--no-ignore-vcs',
          },
        })
      end,
      silent = true,
      desc = 'telescope: find files',
    },
    {
      '<leader>fP',
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
      '<leader>fi',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find({
          default_text = vim.fn.expand('<cword>'),
        })
      end,
      silent = true,
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
          search_dirs = { 'app', 'lib', 'spec', 'ee/app', 'ee/lib', 'ee/spec' },
          prompt_title = 'rails (app, lib, spec)',
        })
      end,
      silent = true,
      desc = 'telescope: rails (app, lib, spec)',
    },
    {
      '<leader>as',
      function()
        require('telescope.builtin').grep_string()
      end,
      mode = { 'n', 'v' },
      silent = true,
      desc = 'telescope: grep string',
    },
  },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')
    local utils = require('utils')

    telescope.load_extension('fzf')

    telescope.setup({
      extensions = {
        fzf = {
          case_mode = 'smart_case',
          fuzzy = true,
          override_file_sorter = true,
          override_generic_sorter = true,
        },
      },

      defaults = {
        dynamic_preview_title = true,
        layout_config = {
          prompt_position = 'top',
          horizontal = {
            height = 0.9,
            mirror = false,
            preview_cutoff = 120,
            preview_width = 0.65,
            width = 0.9,
          },
        },
        layout_strategy = 'horizontal',
        mappings = {
          i = {
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-n>'] = actions.cycle_history_next,
            ['<C-p>'] = actions.cycle_history_prev,
            ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
            ['<C-b>'] = actions.preview_scrolling_up,
            ['<C-f>'] = actions.preview_scrolling_down,
            ['<C-u>'] = { '<c-u>', type = 'command' }, -- delete inputted text
            ['<C-a>'] = { '<home>', type = 'command' }, -- move cursor to the beginning of input
            ['<C-e>'] = { '<end>', type = 'command' }, -- move cursor to the end of input
          },
          n = {
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-n>'] = actions.cycle_history_next,
            ['<C-p>'] = actions.cycle_history_prev,
            ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
            ['<C-b>'] = actions.preview_scrolling_up,
            ['<C-f>'] = actions.preview_scrolling_down,
            ['<C-u>'] = { '<c-u>', type = 'command' }, -- delete inputted text
            ['<C-a>'] = { '<home>', type = 'command' }, -- move cursor to the beginning of input
            ['<C-e>'] = { '<end>', type = 'command' }, -- move cursor to the end of input
          },
        },
        path_display = { 'smart' },
        preview_title = '',
        prompt_prefix = '› ',
        selection_caret = '› ',
        set_env = { ['COLORTERM'] = 'truecolor' },
        sorting_strategy = 'ascending',
        winblend = 0,
      },
    })
    telescope.load_extension('fzf')

    vim.api.nvim_create_user_command('Grep', function(cmd)
      local prompt = 'grep: "%s"'
      local str = cmd.fargs[1]
      local search_args = {
        search = str,
        prompt_title = string.format(prompt, str),
      }

      local dirs = vim.split(cmd.fargs[2] or '', ',', { trimempty = true, plain = true })
      if #dirs > 0 then
        search_args.search_dirs = dirs
        search_args.prompt_title =
          string.format(prompt .. ' (in: %s)', str, table.concat(dirs, ','))
      end

      builtin.grep_string(search_args)
    end, {
      range = 0,
      nargs = '*',
      desc = 'telescope: search the given string `:Grep <string> [dir1,dir2]`',
    })

    utils.augroup('user:fuzzyfinder', {
      {
        events = { 'User' },
        pattern = 'TelescopePreviewerLoaded',
        command = 'setlocal wrap number numberwidth=5 norelativenumber',
      },
      {
        events = { 'FileType' },
        pattern = 'TelescopeResults,TelescopePrompt',
        command = 'setlocal nonumber norelativenumber',
      },
    })
  end,
}
