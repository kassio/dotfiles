local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local utils = require('my.utils')
local keymap = vim.keymap.set
local cmd_keymap = function(mode, map, cmd)
  keymap(mode, map, '<cmd>' .. cmd .. '<cr>')
end

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
      flex = {
        flip_columns = 250,
        flip_lines = 50,
        vertical = {
          height = 0.99,
          width = 0.7,
          mirror = true,
        },
        horizontal = {
          height = 0.99,
          width = 0.99,
          mirror = false,
        },
      },
    },
    layout_strategy = 'flex',
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-u>'] = { '<c-u>', type = 'command' }, -- delete inputted text
        ['<C-a>'] = { '<home>', type = 'command' }, -- move cursor to the beginning of input
        ['<C-e>'] = { '<end>', type = 'command' }, -- move cursor to the end of input
      },
      n = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
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
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    winblend = 0,
  },
})

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
      flex = {
        flip_columns = 250,
        flip_lines = 50,
        vertical = {
          height = 0.99,
          width = 0.7,
          mirror = true,
        },
        horizontal = {
          height = 0.99,
          width = 0.99,
          mirror = false,
        },
      },
    },
    layout_strategy = 'flex',
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-u>'] = { '<c-u>', type = 'command' }, -- delete inputted text
        ['<C-a>'] = { '<home>', type = 'command' }, -- move cursor to the beginning of input
        ['<C-e>'] = { '<end>', type = 'command' }, -- move cursor to the end of input
      },
      n = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
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
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    winblend = 0,
  },
})
telescope.load_extension('fzf')
telescope.load_extension('ui-select')

cmd_keymap('n', 'f<c-p>', 'Telescope find_files find_command=files')
cmd_keymap('n', 'f<c-y>', 'Telescope live_grep')

cmd_keymap('n', 'f<c-f>', 'Telescope builtin')
cmd_keymap('n', 'f<c-h>', 'Telescope help_tags')
cmd_keymap('n', 'f<c-i>', 'Telescope git_files')
cmd_keymap('n', 'f<c-k>', 'Telescope buffers')
cmd_keymap('n', 'f<c-l>', 'Telescope highlights')
cmd_keymap('n', 'f<c-m>', 'Telescope keymaps')
cmd_keymap('n', 'f<c-n>', 'Telescope current_buffer_fuzzy_find')
cmd_keymap('n', 'f<c-o>', 'Telescope oldfiles')
cmd_keymap('n', 'f<c-t>', 'Telescope treesitter')
cmd_keymap('n', 'f<c-u>', 'Telescope commands')

keymap('n', '<leader>as', builtin.grep_string)
vim.api.nvim_create_user_command('Grep', function()
  builtin.grep_string({ search = utils.get_visual_selection() })
end, { range = 0 })

keymap('x', '<leader>as', ':Grep<cr>')

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
