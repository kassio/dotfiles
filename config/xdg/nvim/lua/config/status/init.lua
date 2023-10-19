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

local group = vim.api.nvim_create_augroup('user:statusline', { clear = false })
vim.api.nvim_create_autocmd({ 'RecordingEnter' }, {
  group = group,
  callback = function()
    vim.g.macromsg = string.format('recording @%s', vim.fn.reg_recording())
  end,
})

vim.api.nvim_create_autocmd({ 'RecordingLeave' }, {
  group = group,
  callback = function()
    vim.g.macromsg = vim.v.event.regname .. ' recorded'

    vim.defer_fn(function()
      vim.g.macromsg = ''
    end, 3000)
  end,
})

vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = { 'Tick' },
  group = group,
  callback = vim.cmd.redrawstatus,
})

opt.laststatus = 3 -- global statusline
opt.statuscolumn = render('statuscolumn')
opt.statusline = render('statusline')
opt.tabline = render('tabline')
opt.winbar = render('winbar')
