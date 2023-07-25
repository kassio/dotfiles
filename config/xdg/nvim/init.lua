vim.loader.enable()

-- global functions
require('globals')

-- my config
require('config')

-- To be removed with nvim 0.10
vim.ui.open = function(value)
  vim.fn.jobstart('open ' .. value)
end

pcall(vim.cmd.source, vim.env.HOME .. '/.nvim.lua')
