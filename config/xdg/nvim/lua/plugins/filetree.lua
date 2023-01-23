return {
  'kyazdani42/nvim-tree.lua',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
  },
  keys = {
    { '<leader>p', '<cmd>NvimTreeToggle<cr>', silent = true },
    { '<leader>fl', '<cmd>NvimTreeFindFile<cr>', silent = true },
  },
  config = function()
    local hl = require('utils.highlights')

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
          hint = Theme.icons.hint,
          info = Theme.icons.info,
          warning = Theme.icons.warn,
          error = Theme.icons.error,
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

    hl.def('NvimTreeOpenedFile', { bold = true, italic = true })
    hl.extend('NvimTreeRootFolder', 'NvimTreeFolderName', { bold = true })
  end,
}
