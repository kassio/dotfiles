return {
  'kyazdani42/nvim-tree.lua',
  keys = {
    {
      '<leader>ee',
      '<cmd>NvimTreeToggle<cr>',
      silent = true,
      desc = 'explorer: toggle',
    },

    {
      '<leader>ef',
      function()
        vim.cmd('NvimTreeFindFile')
        vim.cmd('NvimTreeFocus')
      end,
      silent = true,
      desc = 'explorer: find file',
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
        timeout = 1600,
      },
      update_focused_file = { enable = false },
      renderer = {
        add_trailing = true,
        highlight_git = true,
        highlight_opened_files = 'all',
        indent_markers = { enable = true },
        root_folder_label = function(path)
          return '» ' .. vim.fn.fnamemodify(path, ':t')
        end,
      },
      view = {
        number = false,
        preserve_window_proportions = true,
        relativenumber = false,
        side = 'right',
        signcolumn = 'yes',
        width = 32,
      },
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
          return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', '<S-CR>', api.node.open.drop, opts('Open'))

        vim.keymap.set('n', 'A', function()
          local winnr = vim.api.nvim_get_current_win()
          local width = vim.api.nvim_win_get_width(winnr)
          if width <= 32 then
            vim.cmd('NvimTreeResize +60')
          else
            vim.cmd('NvimTreeResize 32')
          end
        end, opts('Toggle Expand Window'))

        vim.keymap.set('n', 'D', function()
          local node = api.tree.get_node_under_cursor()
          local nodebuf = vim.fn.bufnr(node.absolute_path)

          if nodebuf > 0 then
            vim.api.nvim_buf_delete(nodebuf, { force = true })
          end
        end, opts('Delete Buffer'))
      end,
    })
  end,
}
