vim.loader.enable()

-- global functions
require('globals')

-- lua extensions
require('extensions')

-- my config
require('config')

pcall(vim.cmd.source, vim.env.HOME .. '/.nvim.lua')
