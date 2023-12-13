local command = vim.api.nvim_create_user_command
local utils = require('utils')

-- run given command without change current view
command('Preserve', function(cmd)
  utils.preserve(function()
    vim.cmd(cmd.args)
  end)
end, { nargs = '?' })

-- trim the file
command('Trim', function()
  local hlsearch = vim.opt_global.hlsearch:get()
  vim.opt.hlsearch = false

  utils.buffers.preserve(function()
    vim.cmd([[keeppatterns silent! %s/\v\s+$//e]])
    vim.cmd([[keeppatterns silent! %s/\v($\n\s*)+%$//e]])
  end)

  vim.opt.hlsearch = hlsearch
end, {})

-- change background
command('Dark', 'set bg=dark', {})
command('Light', 'set bg=light', {})

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
