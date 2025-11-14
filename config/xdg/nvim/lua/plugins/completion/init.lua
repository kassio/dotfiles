return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    {
      "L3MON4D3/LuaSnip",
      run = "make install_jsregexp",
    },
  },
  version = '1.*',
  config = function()
    require('plugins.completion.snippets').setup()

    require('blink.cmp').setup({
      appearance = {
        nerd_font_variant = 'mono'
      },
      fuzzy = {
        implementation = "prefer_rust",
      },
      completion = {
        documentation = {
          auto_show = true,
        },
      },
      snippets = { preset = 'luasnip' },
      keymap = {
        preset = 'default',

        ['<C-space>'] = {
          function(cmp)
            cmp.show({
              providers = { 'lsp' },
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
        ['<tab>'] = {
          function(cmp)
            if require('luasnip').choice_active() then
              require('luasnip').change_choice(1)
            end
          end
        },
      },
      signature = {
        enabled = true,
      },
      sources = {
        default = {
          'buffer',
          'snippets',
          'lsp',
          'path',
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
        },
      },
    })
  end,
  opts_extend = {
    "sources.default",
  }
}
