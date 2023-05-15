local util = require('lspconfig.util')
local fn = vim.fn

return {
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
}
