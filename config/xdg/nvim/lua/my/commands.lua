local command = vim.api.nvim_create_user_command

-- reload config
command('Reload', vim.my.reloader.reload, {})

-- reload theme
command('ReloadTheme', vim.my.reloader.reload_theme, {})

-- run given command without change current view
command('Preserve', function(cmd)
  vim.my.utils.preserve(function()
    vim.cmd(cmd.args)
  end)
end, { nargs = '?' })

-- trim the file
command('Trim', vim.my.buffers.trim, {})

-- Ensure path exists and writes the file
command('Write', vim.my.buffers.ensure_path_and_write, {})

-- copy filename
command('CopyFilename', vim.my.utils.copy_filename, { bang = true, nargs = '?' })
