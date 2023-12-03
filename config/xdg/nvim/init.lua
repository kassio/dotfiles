vim.loader.enable()

-- global functions
require('globals')

-- my config
require('config')

pcall(vim.cmd.source, vim.fs.joinpath(vim.env.HOME, '.nvim.lua'))
