local session = require('config.session.utils')

local command_map = function(fn, map, cmd_name, cmd_opts)
  cmd_opts = cmd_opts or {}
  vim.api.nvim_create_user_command(cmd_name, fn, cmd_opts)

  if map ~= nil then
    vim.keymap.set('n', map, fn)
  end
end

-- session management
command_map(session.save, '<leader>ss', 'SessionSave', { nargs = '?' })
command_map(session.load, '<leader>sl', 'SessionLoad')
command_map(session.destroy, '<leader>sd', 'SessionDestroy')
command_map(session.destroy_all, '<leader>sD', 'SessionDestroyAll')
