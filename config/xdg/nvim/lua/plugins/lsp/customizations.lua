local util = require('lspconfig.util')
local fn = vim.fn

return {
  sumneko_lua = {
    root_dir = util.root_pattern('.stylua.toml'),
    settings = {
      Lua = {
        format = {
          enabled = false,
        },
        diagnostics = {
          globals = {
            'vim',
            'require',
          },
          unusedLocalExclude = {
            '_*',
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [fn.expand('$VIMRUNTIME/lua')] = true,
            [fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
      },
    },
  },

  gopls = {
    settings = {
      gopls = {
        experimentalPostfixCompletions = true, -- experimental
        gofumpt = false,
        usePlaceholders = true,
        staticcheck = true, -- experimental
        codelenses = {
          generate = true,
          gc_details = true,
          tide = true,
        },
        analyses = {
          nilness = true,
          shadow = true,
          unusedparams = true,
          unusedwrite = true,
        },
      },
    },
  },

  solargraph = {
    root_dir = util.root_pattern('.git', 'Gemfile'),
    settings = {
      solargraph = {
        completion = true,
        symbols = true,
        diagnostics = true,
        definitions = true,
        hover = true,
        references = true,
        rename = true,
        useBundler = true,
      },
    },
  },
}
