local command = vim.api.nvim_create_user_command
local utils = require('my.utils')

-- reload config
command('Reload', utils.reloader.reload, {})

-- reload theme
command('ReloadTheme', utils.reloader.reload_theme, {})

-- run given command without change current view
command('Preserve', function(cmd)
  utils.preserve(function()
    vim.cmd(cmd.args)
  end)
end, { nargs = '?' })

-- trim the file
command('Trim', utils.buffers.trim, {})

-- Ensure path exists and writes the file
command('Write', utils.buffers.ensure_path_and_write, {})

-- copy filename
command('CopyFilename', utils.copy_filename, { bang = true, nargs = '?' })
