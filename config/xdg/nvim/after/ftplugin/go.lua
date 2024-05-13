vim.b.autoformat = false

-- Testing
vim.g['test#go#gotest#executable'] = 'GOFLAGS="-count=1" go test -v'

vim.api.nvim_create_user_command('GoAcceptance', function(c)
  local cmd = string.format("GOFLAGS='-count=1' go test -v ./test/acceptance", c.args)
  if #c.args > 0 then
    cmd = string.format("GOFLAGS='-count=1' go test -v -run '%s' ./test/acceptance", c.args)
  end

  vim.g['test#last_strategy'] = 'terminal'
  vim.g['test#last_command'] = table.concat({ 'clear', 'make', cmd }, ' && ')

  vim.cmd.TestLast()
end, { nargs = '?' })

vim.api.nvim_create_user_command('GoTest', function(c)
  local cmd = string.format("GOFLAGS='-count=1' go test -v ./...", c.args)
  if #c.args > 0 then
    cmd = string.format("GOFLAGS='-count=1' go test -v -run '%s' ./...", c.args)
  end

  vim.g['test#last_strategy'] = 'terminal'
  vim.g['test#last_command'] = cmd

  vim.cmd.TestLast()
end, { nargs = '+' })
