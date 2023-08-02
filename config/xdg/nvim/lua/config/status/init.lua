local warn_icon = require('utils.highlights').get_sign_icon('warn')
local opt = vim.opt

local function render(name)
  local ok, text = pcall(string.format, '%%{%%v:lua.require("config.status.%s").render()%%}', name)

  if not ok then
    return string.format('%s %s %s', warn_icon, name, warn_icon)
  else
    return text
  end
end

-- statuscolumn
opt.number = true
opt.relativenumber = false
opt.numberwidth = 5

-- statusline
opt.laststatus = 3
opt.cmdheight = 0
opt.showcmdloc = 'statusline'

opt.statuscolumn = render('statuscolumn')
opt.statusline = render('statusline')
opt.tabline = render('tabline')
opt.winbar = render('winbar')
