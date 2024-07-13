return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
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
    require('neo-tree').setup({
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
      window = { position = 'right', width = 40 },
      commands = {
        print_me = function(state)
          local node = state.tree:get_node()
          return node.name
        end,
      },
      mappings = {
        ['<space>'] = { 'toggle_node', nowait = false },
        ['<2-LeftMouse>'] = 'open',
        ['<cr>'] = 'open',
        ['<esc>'] = 'cancel',
        ['<c-p>'] = {
          'toggle_preview',
          config = { use_float = true, use_image_nvim = true },
        },
        ['l'] = 'focus_preview',
        ['<c-x>'] = 'open_split',
        ['<c-v>'] = 'open_vsplit',
        ['<c-t>'] = 'open_tabnew',
        ['w'] = 'open_with_window_picker',
        ['C'] = 'close_node',
        ['z'] = 'close_all_nodes',
        ['a'] = {
          'add',
          config = {
            show_path = 'none',
          },
        },
        ['A'] = 'add_directory',
        ['d'] = 'delete',
        ['r'] = 'rename',
        ['y'] = 'copy_to_clipboard',
        ['x'] = 'cut_to_clipboard',
        ['p'] = 'paste_from_clipboard',
        ['c'] = 'copy',
        ['m'] = 'move',
        ['q'] = 'close_window',
        ['R'] = 'refresh',
        ['?'] = 'show_help',
        ['<'] = 'prev_source',
        ['>'] = 'next_source',
        ['K'] = 'show_file_details',
      },

      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = '✚',
            deleted = '✖',
            modified = '',
            renamed = '󰁕',
            -- Status type
            untracked = '',
            ignored = '',
            unstaged = '󰄱',
            staged = '',
            conflict = '',
          },
        },
      },
    })
  end,
}
