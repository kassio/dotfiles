local utils = require('my.utils')
local icons = require('plugins.icons')
local winbar_by_ft = {}

for ft in ipairs(utils.plugin_filetypes) do
  winbar_by_ft[ft] = ''
end

winbar_by_ft[''] = '…'
winbar_by_ft.NvimTree = 'explorer'
winbar_by_ft.neoterm = 'neoterm'
winbar_by_ft.help = 'help'
winbar_by_ft.packer = 'plugins'

local get_name = function(bufnr)
  local fullname = vim.api.nvim_buf_get_name(bufnr)

  if #fullname == 0 then
    return '[No name]'
  else
    local name = vim.fn.fnamemodify(fullname, ':.')

    if #name > 70 then
      local parts = vim.split(name, '/')
      return '.../' .. table.concat(parts, '/', 2, #parts)
    end

    return name
  end
end

local highlight = function(color)
  return string.format('%%#%s#', color)
end

-- HACK: for somereason, calling v:lua.require is not working
vim.api.nvim_exec(
  [[
function! WinbarClick(bufnr, _clicks, button, mods)
  call v:lua.require("plugins.winbar.utils").click(
  \ a:bufnr,
  \ a:button,
  \ a:mods)
endfunction
  ]],
  true
)

return {
  click = function(bufnr, button, mods)
    local text = vim.api.nvim_buf_get_name(bufnr)

    if button ~= 'l' then
      text = vim.fn.fnamemodify(text, ':.')
    end

    utils.to_clipboard(text, vim.fn.stridx(mods, 'c') ~= -1)
  end,
  render = function()
    local ft = vim.bo.filetype
    local winid = vim.api.nvim_get_current_win()

    if vim.tbl_contains(vim.tbl_keys(winbar_by_ft), ft) then
      return '%=' .. winbar_by_ft[ft] .. '%='
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local name = get_name(bufnr)

    local winbar_hl = 'Winbar'
    local icon, icon_hl = icons.buffers.fileicon_extend_hl(bufnr, winbar_hl)

    if tonumber(vim.g.actual_curwin) ~= tonumber(winid) then
      winbar_hl = 'WinbarNC'
      icon_hl = 'WinbarNC'
    end

    return table.concat({
      highlight(winbar_hl),
      '%=',
      highlight(icon_hl),
      icon,
      highlight(winbar_hl),
      '%' .. bufnr .. '@WinbarClick@' .. name .. '%T',
      '%n',
      '%=',
    }, ' ')
  end,
}
