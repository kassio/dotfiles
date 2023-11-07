vim.loader.enable()

-- global functions
require('globals')

-- my config
require('config')

pcall(vim.cmd.source, vim.env.HOME .. '/.nvim.lua')
