local function runtime(...)
  return vim.fs.joinpath(vim.env.VIMRUNTIME, ...)
end

return {
  cmd = { 'lua-language-server' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
  },
  filetypes = { 'lua' },
  single_file_support = true,
  init_options = {
    telemetry = { enable = false },
    hint = { enable = true },
    format = { enable = false },
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
}
