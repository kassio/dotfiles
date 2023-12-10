return {
  setup = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = 'all',
      ignore_install = {
        'agda',
        'kotlin',
        'latex',
        'norg',
        'ocaml',
        'php',
        'phpdoc',
        'r',
        'vala',
        'wing',
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
            [']F'] = '@function.outer',
            [']C'] = '@class.outer',
          },
          goto_next_end = {
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[C'] = '@class.outer',
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
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
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
