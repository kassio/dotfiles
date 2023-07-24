return {
  setup = function()
    require('nvim-treesitter.configs').setup({
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
}
