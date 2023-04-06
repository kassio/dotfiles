local opt = vim.opt

local function render(name)
  return string.format('%%{%%v:lua.require("config.status.%s").render()%%}', name)
end

-- statuscolumn
opt.number = true
opt.relativenumber = true
opt.numberwidth = 5

-- statusline
opt.laststatus = 3
opt.cmdheight = 0
opt.showcmdloc = 'statusline'

opt.statuscolumn = render('statuscolumn')
opt.statusline = render('statusline')
opt.tabline = render('tabline')
opt.winbar = render('winbar')
