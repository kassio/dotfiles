local theme = vim.my.theme

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
      hint = theme.signs.hint,
      info = theme.signs.info,
      warning = theme.signs.warn,
      error = theme.signs.error,
    },
  },
  filters = { dotfiles = true },
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
  },
})

vim.keymap.set('n', '<leader>p', ':NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>fl', ':NvimTreeFindFile<CR>', { silent = true })