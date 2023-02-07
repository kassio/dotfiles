local session = require('config.session.utils')

vim.api.nvim_create_user_command('SessionSave', session.save, { desc = 'session: save' , nargs = '?' })
vim.keymap.set('n', '<leader>ss', session.save, { desc = 'session: save' })

vim.api.nvim_create_user_command('SessionLoad', session.load, { desc = 'session: load' })
vim.keymap.set('n', '<leader>sl', session.load, { desc = 'session: load' })

vim.api.nvim_create_user_command('SessionDestroy', session.destroy, { desc = 'session: destroy' })
vim.keymap.set('n', '<leader>sd', session.destroy, { desc = 'session: destroy' })

vim.api.nvim_create_user_command('SessionDestroyAll', session.destroy_all, { desc = 'session: destroy all sessions' })
vim.keymap.set('n', '<leader>sD', session.destroy_all, { desc = 'session: destroy all sessions' })
