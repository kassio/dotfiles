return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'f3fora/cmp-spell',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'bydlw98/cmp-env',
    'ray-x/cmp-treesitter',
    -- snippets
    'dcampos/nvim-snippy',
    'dcampos/cmp-snippy',
  },
  config = function()
    local cmp = require('cmp')
    local mapping = cmp.mapping
    local snippy = require('snippy')

    snippy.setup({
      mappings = {
        is = {
          ['<tab>'] = 'expand_or_advance',
          ['<s-tab>'] = 'previous',
        },
        nx = {
          ['<tab>'] = 'cut_text',
        },
      },
    })

    cmp.setup({
      formatting = require('plugins.completion.formatting'),

      mapping = {
        ['<c-n>'] = mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<c-p>'] = mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<down>'] = mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<up>'] = mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<c-d>'] = mapping.scroll_docs(-4),
        ['<c-f>'] = mapping.scroll_docs(4),
        ['<c-space>'] = mapping.complete(),
        ['<c-y>'] = mapping.confirm(),
        ['<c-e>'] = mapping.abort(),
        ['<cr>'] = cmp.mapping.confirm({ select = false }),
      },

      snippet = {
        expand = function(args)
          snippy.expand_snippet(args.body)
        end,
      },

      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'snippy' },
      }, {
        { name = 'treesitter' },
        { name = 'buffer' },
        { name = 'spell' },
      }, {
        { name = 'nvim_lua' },
      }, {
        { name = 'path' },
        { name = 'env' },
      }),

      window = {
        completion = cmp.config.window.bordered({
          scrollbar = true,
          max_width = 80,
        }),
        documentation = cmp.config.window.bordered({
          scrollbar = true,
          max_width = 80,
        }),
      },
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' },
          },
        },
      }),
    })
  end,
}
