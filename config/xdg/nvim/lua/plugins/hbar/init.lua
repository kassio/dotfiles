local renderer = function(name)
  return string.format('%%{%%v:lua.require("plugins.hbar.%s").render()%%}', name)
end

vim.opt.laststatus = 3
vim.opt.statusline = renderer('statusline')
vim.opt.tabline = renderer('tabline')
vim.opt.winbar = renderer('winbar')