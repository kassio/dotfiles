local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local themes = require('telescope.themes')
local utils = require('my.utils')
local keymap = vim.keymap.set

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

-- git
-- git modified files
keymap('n', 'f<c-g>m', function()
  local args = {
    'git',
    'ls-files',
    '--modified',
  }

  builtin.find_files({ find_command = args })
end)

-- git modified files (in relation to the main branch)
keymap('n', 'f<c-g>d', function()
  local main = vim.fn.system('git-branch-main')
  local args = {
    'git',
    'diff',
    '--name-only',
    '--relative',
    string.format('%s...', vim.trim(main)),
  }

  builtin.find_files({ find_command = args })
end)

keymap('n', 'f<c-g>g', builtin.git_files)

keymap('n', 'f<c-p>', function()
  builtin.find_files({ find_command = { 'files' } })
end)

keymap('n', 'f<c-;>', function()
  builtin.find_files(themes.get_ivy({ find_command = { 'files' } }))
end)

keymap('n', 'f<c-r>', function()
  builtin.find_files({
    find_command = { 'files' },
    search_dirs = { 'app', 'lib', 'ee/app', 'ee/lib' },
  })
end)

keymap('n', 'f<c-y>', builtin.live_grep)
keymap('n', 'f<c-f>', builtin.builtin)
keymap('n', 'f<c-h>', builtin.help_tags)
keymap('n', 'f<c-k>', builtin.buffers)
keymap('n', 'f<c-l>', builtin.highlights)
keymap('n', 'f<c-m>', builtin.keymaps)
keymap('n', 'f<c-n>', builtin.current_buffer_fuzzy_find)
keymap('n', 'f<c-o>', builtin.oldfiles)
keymap('n', 'f<c-t>', builtin.treesitter)
keymap('n', 'f<c-u>', builtin.commands)
keymap('n', '<leader>as', builtin.grep_string)
keymap('x', '<leader>as', ':Grep<cr>')

vim.api.nvim_create_user_command('Grep', function()
  builtin.grep_string({ search = utils.get_visual_selection() })
end, { range = 0 })

vim.api.nvim_create_user_command('GrepIn', function(cmd)
  local dirs = vim.split(cmd.args, ',', { trimempty = true, plain = true })
  builtin.grep_string({ search = utils.get_visual_selection(), search_dirs = dirs })
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
