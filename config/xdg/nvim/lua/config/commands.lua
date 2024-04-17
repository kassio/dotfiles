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
  utils.buffers.preserve(function()
    vim.cmd([[keeppatterns silent! %s/\v\s+$//e]])
    vim.cmd([[keeppatterns silent! %s/\v($\n\s*)+%$//e]])
  end)
end, {})

-- change background
command('Dark', 'set background=dark', {})
command('Light', 'set background=light', {})

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

command('Reverse', function(opts)
  vim.cmd(string.format('%s,%s g/^/move %s', opts.line1, opts.line2, opts.line1 - 1))
  vim.cmd.nohls()
end, { range = '%' })
