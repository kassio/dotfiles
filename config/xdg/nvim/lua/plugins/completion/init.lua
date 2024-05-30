return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'bydlw98/cmp-env',
    'f3fora/cmp-spell',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-omni',
    'hrsh7th/cmp-path',
    'ray-x/cmp-treesitter',
    -- snippets
    'dcampos/cmp-snippy',
    'dcampos/nvim-snippy',
  },
  config = function()
    local cmp = require('cmp')
    local mapping = cmp.mapping
    local snippy = require('snippy')

    snippy.setup({
      mappings = {
        nx = {
          ['<c-s>'] = 'cut_text',
        },
      },
    })

    cmp.setup({
      formatting = require('plugins.completion.formatting'),

      mapping = {
        ['<c-n>'] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          else
            cmp.complete()
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          end
        end, { 'i', 'c' }),
        ['<c-p>'] = mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<c-d>'] = mapping.scroll_docs(-4),
        ['<c-f>'] = mapping.scroll_docs(4),
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
        { name = 'omni' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'snippy' },
      }, {
        { name = 'rubocop' },
        {
          name = 'buffer',
          option = {
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end,
          },
        },
        { name = 'treesitter' },
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
