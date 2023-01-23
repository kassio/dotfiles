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

    vim.api.nvim_create_user_command('RSpec', function()
      vim.g['test#last_position'] = {
        file = 'spec/models/file_spec.rb',
        col = 1,
        line = 1,
      }

      vim.cmd('TestSuite')
    end, {})

    vim.cmd('cabbrev Rspec RSpec')
  end,
}
