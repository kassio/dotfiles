vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = false

local dap_go = require('dap-go')
dap_go.setup()

vim.api.nvim_create_user_command('GoDebugTest', dap_go.debug_test, {})
vim.keymap.set('n', '<leader>dt', '<cmd>GoDebugTest<cr>')

vim.api.nvim_create_user_command('GoAcceptance', function(cmd)
  local cmds = {
    'clear',
    'make',
    string.format("GOFLAGS='-count=1' go test -v -run '%s' ./test/acceptance", cmd.args),
  }
  vim.cmd.T(table.concat(cmds, ' && '))
end, { nargs = 1 })
