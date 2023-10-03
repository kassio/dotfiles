return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  cmd = 'Telescope',
  keys = require('plugins.fuzzyfinder.keymaps'),
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')
    local layout_actions = require('telescope.actions.layout')
    local utils = require('utils')

    telescope.setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
      defaults = {
        dynamic_preview_title = true,
        cycle_layout_list = {
          'horizontal',
          'bottom_pane',
          'vertical',
        },
        layout_config = {
          prompt_position = 'top',
          horizontal = {
            height = 0.9,
            mirror = false,
            preview_cutoff = 120,
            preview_width = 0.65,
            width = 0.9,
          },
          vertical = {
            mirror = true,
            width = 0.9,
          },
          flex = {
            width = 0.8,
            flip_columns = 180,
            flip_lines = 30,
          },
        },
        layout_strategy = 'flex',
        mappings = {
          i = {
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-n>'] = actions.cycle_history_next,
            ['<C-p>'] = actions.cycle_history_prev,
            ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
            ['<C-b>'] = actions.preview_scrolling_up,
            ['<C-f>'] = actions.preview_scrolling_down,
            ['<C-l>'] = layout_actions.cycle_layout_next,
            ['<C-;>'] = layout_actions.toggle_preview,
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
            ['<C-l>'] = layout_actions.cycle_layout_next,
            ['<C-;>'] = layout_actions.toggle_preview,
            ['<C-u>'] = { '<c-u>', type = 'command' }, -- delete inputted text
            ['<C-a>'] = { '<home>', type = 'command' }, -- move cursor to the beginning of input
            ['<C-e>'] = { '<end>', type = 'command' }, -- move cursor to the end of input
          },
        },
        preview_title = '',
        prompt_prefix = '› ',
        results_title = '',
        scroll_strategy = 'limit', -- do not cycle results
        selection_caret = '› ',
        set_env = { ['COLORTERM'] = 'truecolor' },
        sorting_strategy = 'ascending',
        winblend = 0,
        wrap_results = true,
      },
    })

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

    require('telescope').load_extension('refactoring')
    require('telescope').load_extension('fzf')
  end,
}
