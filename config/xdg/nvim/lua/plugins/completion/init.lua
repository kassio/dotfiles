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
    'JMarkin/cmp-diag-codes',
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql', 'plsql' },
      lazy = true,
    },
    -- snippets
    'dcampos/cmp-snippy',
    'dcampos/nvim-snippy',
  },
  config = function()
    local cmp = require('cmp')
    local mapping = cmp.mapping
    local snippy = require('snippy')

    local has_words_before = function()
      local unpack = require('utils.table').unpack

      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      if col == 0 then
        return
      end

      local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)
      return text[1]:sub(col, col):match('%s') == nil
    end

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
        ['<c-n>'] = mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif snippy.can_expand_or_advance() then
            snippy.expand_or_advance()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<c-p>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif snippy.can_jump(-1) then
            snippy.previous()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<c-d>'] = mapping.scroll_docs(-4),
        ['<c-f>'] = mapping.scroll_docs(4),
        ['<c-y>'] = mapping.confirm(),
        ['<c-e>'] = mapping.abort(),
        ['<cr>'] = mapping.confirm({ select = false }),
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
      }, {
        name = 'diag-codes',
        option = { in_comment = true },
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

    cmp.setup.filetype({ 'sql' }, {
      sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
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
