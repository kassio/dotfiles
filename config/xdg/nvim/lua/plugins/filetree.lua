return {
  'kyazdani42/nvim-tree.lua',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
  },
  keys = {
    {
      '<leader>pp',
      '<cmd>NvimTreeToggle<cr>',
      silent = true,
      desc = 'filetree: toggle',
    },

    {
      '<leader>pf',
      '<cmd>NvimTreeFindFile<cr>',
      silent = true,
      desc = 'filetree: find file',
    },
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
          hint = hl.get_sign_icon('hint'),
          info = hl.get_sign_icon('info'),
          warning = hl.get_sign_icon('warn'),
          error = hl.get_sign_icon('error'),
        },
      },
      filters = {
        custom = { '^\\.git\\>' },
      },
      git = {
        enable = true,
        ignore = false,
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
  end,
}
