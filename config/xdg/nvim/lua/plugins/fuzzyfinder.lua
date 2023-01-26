return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    {
      'f<c-p>',
      function()
        require('telescope.builtin').find_files()
      end,
      desc = 'find files',
    },

    {
      'f<c-;>',
      function()
        require('telescope.builtin').find_files(require('telescope.themes').get_ivy())
      end,
      desc = 'files [non block]',
    },

    {
      'f<c-s-p>',
      function()
        require('telescope.builtin').resume()
      end,
      desc = 'resume fuzzyfinder',
    },

    {
      'f<c-/>',
      function()
        require('telescope.builtin').live_grep()
      end,
      desc = 'live grep',
    },

    {
      'f<c-f>',
      function()
        require('telescope.builtin').builtin()
      end,
      desc = 'finders',
    },

    {
      'f<c-h>',
      function()
        require('telescope.builtin').help_tags()
      end,
      desc = 'help tags',
    },

    {
      'f<c-b>',
      function()
        require('telescope.builtin').buffers()
      end,
      desc = 'buffers',
    },

    {
      'f<c-l>',
      function()
        require('telescope.builtin').highlights()
      end,
      desc = 'highlights',
    },

    {
      'f<c-k>',
      function()
        require('telescope.builtin').keymaps()
      end,
      desc = 'keymaps',
    },

    {
      'f<c-.>',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find()
      end,
      desc = 'current buffer finder',
    },

    {
      'f<c-o>',
      function()
        require('telescope.builtin').oldfiles()
      end,
      desc = 'oldfiles',
    },

    {
      'f<c-t>',
      function()
        require('telescope.builtin').treesitter()
      end,
      desc = 'treesitter',
    },

    {
      'f<c-,>',
      function()
        require('telescope.builtin').commands()
      end,
      desc = 'commands',
    },

    {
      'f<c-g>g',
      function()
        require('telescope.builtin').git_files()
      end,
      desc = 'git: files',
    },

    {
      'f<c-g>m',
      function()
        require('telescope.builtin').find_files({
          find_command = { 'git', 'ls-files', '--modified' },
          prompt_title = 'git: modified files',
        })
      end,
      desc = 'git: modified files',
    },

    {
      'f<c-g>d',
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
      desc = 'git: branch diff',
    },

    {
      'f<c-r>',
      function()
        require('telescope.builtin').find_files({
          search_dirs = { 'app', 'lib', 'ee/app', 'ee/lib' },
          prompt_title = 'rails (app, lib)',
        })
      end,
      desc = 'rails (app, lib)',
    },

    {
      'f<c-s-r>',
      function()
        require('telescope.builtin').find_files({
          search_dirs = { 'app', 'lib', 'spec', 'ee/app', 'ee/lib', 'ee/spec' },
          prompt_title = 'rails (app, lib)',
        })
      end,
      desc = 'rails (app, lib, spec)',
    },

    {
      '<leader>as',
      function()
        require('telescope.builtin').grep_string()
      end,
      desc = 'grep string',
    },

    {
      '<leader>as',
      function()
        local str = require('utils').get_visual_selection()

        require('telescope.builtin').grep_string({
          search = str,
          prompt_title = string.format('grep: "%s"', str),
        })
      end,
      mode = 'x',
      desc = 'grep string',
    },
  },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')
    local utils = require('utils')

    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')

    telescope.setup({
      extensions = {
        fzf = {
          case_mode = 'smart_case',
          fuzzy = true,
          override_file_sorter = true,
          override_generic_sorter = true,
        },
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
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
    telescope.load_extension('ui-select')

    vim.api.nvim_create_user_command('Grep', function(cmd)
      local args = vim.split(cmd.args, ' ')
      local str = args[1]
      local dirs = vim.split(args[2] or '', ',', { trimempty = true, plain = true })
      local prompt = string.format('grep: "%s"', str)

      if #dirs > 0 then
        prompt = prompt .. string.format(' (in: %s)', table.concat(dirs, ', '))
      end

      builtin.grep_string({
        search = str,
        search_dirs = dirs,
        prompt_title = prompt,
      })
    end, { range = 0, nargs = '*' })

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
