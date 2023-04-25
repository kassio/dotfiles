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
    'ray-x/cmp-treesitter',
    -- snippets
    'dcampos/nvim-snippy',
    'dcampos/cmp-snippy',
  },
  config = function()
    local cmp = require('cmp')
    local mapping = cmp.mapping
    local snippy = require('snippy')
    local symbols = require('utils.symbols')

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

    local MAX_LABEL_WIDTH = 50
    local function whitespace(max, len)
      return (' '):rep(max - len)
    end

    cmp.setup({
      formatting = {
        fields = { 'kind', 'abbr' },
        format = function(entry, item)
          -- Limit content width.
          local content = item.abbr
          if #content > MAX_LABEL_WIDTH then
            item.abbr = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. '…'
          else
            item.abbr = content .. whitespace(MAX_LABEL_WIDTH, #content)
          end

          item.kind = table.concat(vim.tbl_filter(function(i)
            return i ~= ''
          end, {
            symbols.lspsource[entry.source.name] or '',
            symbols.lspkind[item.kind] or symbols.lspkind.Unknown,
          }), ' ')..'|'

          item.menu = nil

          return item
        end,
      },

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
        { name = 'snippy' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
      }, {
        { name = 'treesitter' },
        { name = 'buffer' },
        { name = 'spell' },
      }, {
        { name = 'nvim_lua' },
      }, {
        { name = 'path' },
      }),

      window = {
        documentation = {
          border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })
  end,
}
