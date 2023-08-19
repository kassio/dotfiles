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

-- change background
command('Dark', 'set bg=dark', {})
command('Light', 'set bg=light', {})
command('CheckAppearance', function()
  local obj = vim.system({ 'macos-appearance' }, { text = true }):wait()

  vim.opt.background = vim.trim(obj.stdout) or 'light'
end, {})

-- copy filename
command('CopyFilename', utils.copy_filename, {
  bang = true,
  nargs = '?',
})

command('Draft', function()
  vim.opt_local.buftype = 'nofile'
  vim.opt_local.bufhidden = 'hide'
  vim.opt_local.buflisted = false
end, {})

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
