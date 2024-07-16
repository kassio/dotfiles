return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    {
      's1n7ax/nvim-window-picker',
      name = 'window-picker',
      event = 'VeryLazy',
      version = '2.*',
      config = function()
        require('window-picker').setup({
          hint = 'statusline-winbar',
        })
      end,
    },
  },
  keys = {
    {
      '<leader>ee',
      function()
        require('neo-tree.command').execute({
          action = 'focus',
          toggle = true,
          reveal_force_cwd = false,
        })
      end,
      desc = 'explorer: toggle',
    },
    {
      '<leader>ef',
      function()
        require('neo-tree.command').execute({
          action = 'focus',
          reveal_force_cwd = true,
        })
      end,
      desc = 'Open neo-tree at current file or working directory',
    },
  },
  config = function()
    local symbols = require('utils.symbols')

    require('neo-tree').setup({
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
      window = { position = 'right', width = 40 },
      filesystem = {
        window = {
          mappings = {
            ['<cr>'] = 'open_with_window_picker',
            ['<c-x>'] = 'split_with_window_picker',
            ['<c-v>'] = 'vsplit_with_window_picker',
            ['<c-t>'] = 'open_tabnew',
          },
        },
      },
      mappings = {
        ['<space>'] = { 'toggle_node', nowait = false },
        ['<2-LeftMouse>'] = 'open',
        ['<c-p>'] = {
          'toggle_preview',
          config = { use_float = true, use_image_nvim = true },
        },
        ['K'] = 'show_file_details',
      },

      event_handlers = {
        {
          event = 'neo_tree_window_after_open',
          handler = function()
            vim.cmd.wincmd('=')
          end,
        },
      },

      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = symbols.git.added,
            deleted = symbols.git.removed,
            modified = symbols.git.changed,
            renamed = symbols.git.changed,
            -- Status type
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
          },
        },
      },
    })
  end,
}
