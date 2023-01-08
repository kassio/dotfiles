vim.opt.laststatus = 3
vim.opt.statusline = '%{%v:lua.require("plugins.statusline.renderer").render()%}'
