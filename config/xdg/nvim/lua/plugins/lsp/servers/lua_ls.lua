local function runtime(...)
  return vim.fs.joinpath(vim.env.VIMRUNTIME, ...)
end

return {
  settings = {
    Lua = {
      telemetry = { enable = false },
      hint = { enable = true },
      format = {
        enable = true,
        defaultConfig = {
          quote_style = 'single',
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
          [runtime('lua')] = true,
          [runtime('lua', 'vim', 'lsp')] = true,
        },
      },
    },
  },
}
