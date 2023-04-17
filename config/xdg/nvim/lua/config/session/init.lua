local session = require('config.session.utils')
local command = vim.api.nvim_create_user_command
local keymap = vim.keymap

command('SessionSave', session.save, {
  desc = 'session: save',
  nargs = '?',
})
keymap.set('n', '<leader>ss', session.save, {
  desc = 'session: save',
})

command('SessionLoad', session.load, {
  desc = 'session: load',
})
keymap.set('n', '<leader>sl', session.load, {
  desc = 'session: load',
})

command('SessionDestroy', session.destroy, {
  desc = 'session: destroy',
})
keymap.set('n', '<leader>sd', session.destroy, {
  desc = 'session: destroy',
})

command('SessionDestroyAll', session.destroy_all, {
  desc = 'session: destroy all sessions',
})
keymap.set('n', '<leader>sD', session.destroy_all, {
  desc = 'session: destroy all sessions',
})
