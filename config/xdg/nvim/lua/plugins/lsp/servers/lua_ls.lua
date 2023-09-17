return {
  settings = {
    Lua = {
      telemetry = { enable = false },
      hint = { enable = true },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
        },
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
          [vim.fs.joinpath(vim.env.VIMRUNTIME, 'lua')] = true,
          [vim.fs.joinpath(vim.env.VIMRUNTIME, 'lua', 'vim', 'lsp')] = true,
        },
      },
    },
  },
}
