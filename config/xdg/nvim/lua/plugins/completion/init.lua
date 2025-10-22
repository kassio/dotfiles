return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  version = '1.*',
  opts = {
    appearance = {
      nerd_font_variant = 'mono'
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
    completion = {
      documentation = {
        auto_show = true,
      },
    },
    keymap = {
      preset = 'default',

      ['<C-space>'] = {
        function(cmp)
          cmp.show({
            providers = { 'snippets' },
          })
        end,
      },
      ['<C-p>'] = {
        'show',
        'select_prev',
        'fallback',
      },
      ['<C-n>'] = {
        'show',
        'select_next',
        'fallback',
      },
      ['<C-k>'] = {
        'show_signature',
        'hide_signature',
        'fallback',
      },
    },
    signature = {
      enabled = true,
    },
    sources = {
      default = {
        'snippets',
        'lsp',
        'path',
        'buffer',
      },
      min_keyword_length = 0,
      providers = {
        path = {
          opts = {
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },
        snippets = {
          opts = {
            search_paths = {
              vim.fn.stdpath('config') .. '/snippets'
            }
          }
        }
      },
    },
  },
  opts_extend = {
    "sources.default",
  }
}
