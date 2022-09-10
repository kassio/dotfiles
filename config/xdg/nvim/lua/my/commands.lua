local command = vim.api.nvim_create_user_command
local utils = require('my.utils')

-- run given command without change current view
command('Preserve', function(cmd)
  utils.preserve(function()
    vim.cmd(cmd.args)
  end)
end, { nargs = '?' })

-- trim the file
command('Trim', utils.buffers.trim, {})

-- Ensure path exists and writes the file
command('Write', function()
  local path = vim.fn.expand('%:h')
  vim.fn.mkdir(path, 'p')
  vim.cmd('update!')
end, {})

-- copy filename
command('CopyFilename', utils.copy_filename, { bang = true, nargs = '?' })

command('LockWindowSize', function()
  vim.opt_local.winfixwidth = true
  vim.opt_local.winfixheight = true
end, {})

command('UnlockWindowSize', function()
  vim.opt_local.winfixwidth = false
  vim.opt_local.winfixheight = false
end, {})
