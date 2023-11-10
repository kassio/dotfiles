local warn_icon = require('utils.highlights').get_sign_icon('warn')

local function render(name)
  local ok, text =
    pcall(string.format, '%%{%%v:lua.require("config.status.modules.%s").render()%%}', name)

  if not ok then
    return string.format('%s %s %s', warn_icon, name, warn_icon)
  else
    return text
  end
end

return {
  setup = function()
    require('config.status.autocmds').setup()
    vim.opt.laststatus = 3 -- global statusline
    vim.opt.statuscolumn = render('statuscolumn')
    vim.opt.statusline = render('statusline')
    vim.opt.tabline = render('tabline')
    vim.opt.winbar = render('winbar')
  end,
}
