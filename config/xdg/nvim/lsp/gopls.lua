return {
  cmd = { vim.fs.joinpath(vim.env.HOME, 'src/go/bin/gopls') },
  root_markers = { 'go.work', 'go.mod' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
}
