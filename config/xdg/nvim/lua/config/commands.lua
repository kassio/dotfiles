local command = vim.api.nvim_create_user_command
local utils = require('utils')

-- run given command without change current view
command('Preserve', function(cmd)
  utils.preserve(function()
    vim.cmd(cmd.args)
  end)
end, { nargs = '?' })

-- trim the file
command('Trim', utils.buffers.trim, {})

-- Ensure path exists and writes the file
command('WriteWithPath', function()
  local path = vim.fn.expand('%:h')
  vim.fn.mkdir(path, 'p')
  vim.cmd('write!')
end, {})

-- copy filename
command('CopyFilename', utils.copy_filename, { bang = true, nargs = '?' })


-- window size fix/unfix
local fix_window_size = function()
  vim.opt_local.winfixwidth = true
  vim.opt_local.winfixheight = true
end

local unfix_window_size = function()
  vim.opt_local.winfixwidth = false
  vim.opt_local.winfixheight = false
end

command('LockWindowSize', fix_window_size, {})
command('FixWindowSize', fix_window_size, {})
command('UnlockWindowSize', unfix_window_size, {})
command('UnfixWindowSize', unfix_window_size, {})