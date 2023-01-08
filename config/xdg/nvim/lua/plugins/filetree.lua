local theme = require('plugins.highlight.theme')
local hl = require('my.utils.highlights')
local api = require('nvim-tree.api')

hl.def('NvimTreeOpenedFile', { bold = true, italic = true })
hl.extend('NvimTreeRootFolder', 'NvimTreeFolderName', { bold = true })

require('nvim-tree').setup({
  disable_netrw = true,
  hijack_netrw = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = theme.icons.hint,
      info = theme.icons.info,
      warning = theme.icons.warn,
      error = theme.icons.error,
    },
  },
  filters = {
    custom = { '^\\.git\\>' },
  },
  git = {
    enable = true,
    ignore = false,
  },
  ignore_ft_on_setup = {
    '.git',
    'node_modules',
    'dump.rdb',
    '.byebug_history',
    '.vscode',
    '.idea',
  },
  update_focused_file = { enable = false },
  renderer = {
    add_trailing = true,
    highlight_git = true,
    highlight_opened_files = 'all',
    indent_markers = { enable = true },
  },
  view = {
    number = false,
    preserve_window_proportions = true,
    relativenumber = false,
    side = 'right',
    signcolumn = 'yes',
    width = 32,
    mappings = {
      custom_only = false,
      list = {
        { key = { 'f' }, mode = 'n', action = '' },
        {
          key = { 'A' },
          mode = 'n',
          action = 'toggle_size',
          action_cb = function()
            local winnr = vim.api.nvim_get_current_win()
            local width = vim.api.nvim_win_get_width(winnr)
            if width <= 32 then
              vim.cmd('NvimTreeResize +50')
            else
              vim.cmd('NvimTreeResize 32')
            end
          end,
        },
      },
    },
  },
})

vim.keymap.set('n', '<leader>p', api.tree.toggle, { silent = true })
vim.keymap.set('n', '<leader>fl', function()
  api.tree.toggle({ find_file = true })
end, { silent = true })
