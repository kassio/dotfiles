return {
  'vim-test/vim-test',
  keys = {
    { '<leader>ta', '<cmd>Tclear | TestSuite<cr>' },
    { '<leader>tf', '<cmd>Tclear | TestFile<cr>' },
    { '<leader>tc', '<cmd>Tclear | TestNearest<cr>' },
    { '<leader>tr', '<cmd>Tclear | TestLast<cr>' },
  },
  config = function()
    vim.g['test#strategy'] = 'neoterm'
    vim.g['test#go#gotest#executable'] = 'GOFLAGS="-count=1" go test -v'
  end,
}
