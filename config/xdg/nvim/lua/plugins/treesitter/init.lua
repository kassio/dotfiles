return {
  {
    'Wansmer/treesj',
    cmd = { 'TSJJoin', 'TSJSplit', 'TSJToggle' },
    keys = {
      { 'gJ', '<cmd>TSJJoin<cr>', silent = true, desc = 'tsj: join nodes' },
      { 'gS', '<cmd>TSJSplit<cr>', silent = true, desc = 'tsj: split nodes' },
    },
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',

      'theHamsta/nvim-treesitter-pairs',

      -- Better pairs matching
      'andymass/vim-matchup',
    },
    config = function()
      local treesitter = require('nvim-treesitter.configs')

      require('plugins.treesitter.refactor')
      require('plugins.treesitter.context')
      require('plugins.treesitter.highlights')

      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.o.foldenable = false

      -- vim-matchup plugin, uses treesitter
      -- Do not show the not visible matching context on statusline
      vim.g.matchup_matchparen_offscreen = {}

      treesitter.setup({
        ensure_installed = 'all',
        ignore_install = {
          'kotlin',
          'latex',
          'norg',
          'ocaml',
          'php',
          'phpdoc',
          'r',
          'vala',
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
          disable = { 'ruby' },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = 'gnn',
            node_decremental = 'gnm',
          },
        },
        textobjects = {
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          pairs = {
            enable = true,
          },
          select = {
            enable = true,
            keymaps = {
              ['ab'] = '@block.outer',
              ['ib'] = '@block.inner',
              ['am'] = '@function.outer',
              ['im'] = '@function.inner',
              ['aM'] = '@class.outer',
              ['iM'] = '@class.inner',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
        refactor = {
          highlight_definitions = { enable = true },
          highlight_current_scope = { enable = true },
          navigation = { enable = true },
          smart_rename = { enable = true },
        },
        matchup = {
          enable = true,
        },
        playground = {
          enable = true,
          updatetime = 25,
          persist_queries = false,
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { 'BufWrite', 'CursorHold' },
        },
      })
    end,
  },
}
